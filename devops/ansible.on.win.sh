#!/usr/bin/env bash

#########
#
#  ANSIBLE ON WINDOWS INSTALL STEPS
#
#  STEP 1: Add Ansible Building Tools
#
#+ pacman -S base-devel libffi libffi-devel pkg-config gmp gmp-devel openssh openssl openssl-devel git python2 python2-setuptools

##
# Read Instruction Here : https://pip.pypa.io/en/stable/installing/
# pip vs setuptools : https://packaging.python.org/pip_easy_install/#pip-vs-easy-install
##

#
#  STEP 2: 
# 	+ i] Install Python-pip
#
#+ mkdir /usr/local/src/ ; cd /usr/local/src/ ; wget https://bootstrap.pypa.io/get-pip.py
#+ python get-pip.py
#
# 	+ ii] Fix pyconfig.h FreeBSD library visibility From 1 -> 0
#
# /usr/include/python2.7/pyconfig.h:1222:0: warning: "__BSD_VISIBLE" redefined
# #define __BSD_VISIBLE 1
#
# /* Define on FreeBSD to activate all library features */
#+ #define __BSD_VISIBLE 0
#
#  STEP 3: Install Ansible Using Pip
#
#+ pip install -U -r $HOME/devops/ansible.pip.requirements.txt
#
#######

ANSIBLE_DIR=$HOME/.ansible

CURRENT_DIR=$( pwd )

if [ -f /etc/ansible-on-win.installed ]
  then
    echo "First init setting up Ansible On Win."
    cd $ANSIBLE_DIR
    if [ $BOOTSTRAP_ANSIBLE_UPDATE = 1 ]
     then
     echo "Performing Ansible update from source, if available."
     #Setup rebase Ansible
     git pull --rebase
     git submodule update --init --recursive
    fi
    source ./hacking/env-setup
    cd $CURRENT_DIR

	echo "Update Ansible Vagrant Shims in bin Directory"
	cp -r $HOME/ansible-on-win/ansible-playbook.bat $HOME/ansible/bin/ansible-playbook.bat

    echo "Remember to setup the ssh-agent."

  else
    #Replace babun sudo with new fake sudo for Ansible, throwing way all sudo args.
    echo "#!/usr/bin/env bash" > /usr/bin/sudo
    echo "count=0" >> /usr/bin/sudo
    echo "for var in "$@"" >> /usr/bin/sudo
    echo "  do" >> /usr/bin/sudo
    echo "    (( count++ ))" >> /usr/bin/sudo
    echo "  done" >> /usr/bin/sudo
    echo "shift $count" >> /usr/bin/sudo
    echo "exec "$@"" >> /usr/bin/sudo

    #Install Ansible Prereqs
    pact install python
    pact install python-paramiko
    pact install python-crypto
    pact install gcc-g++
    pact install wget
    pact install openssh
    pact install python-setuptools
    pact install libyaml-devel
    easy_install pip
    pip install PyYAML Jinja2 httplib2 boto awscli

    #Create initial Ansible hosts inventory
    mkdir -p /etc/ansible/
    echo "127.0.0.1" > /etc/ansible/hosts
    chmod -x /etc/ansible/hosts

    #Setup Ansible from Source
    mkdir -p $ANSIBLE_DIR
    git clone git://github.com/ansible/ansible.git --recursive $ANSIBLE_DIR
    cd $ANSIBLE_DIR
    source ./hacking/env-setup
    cd $CURRENT_DIR

	echo "Copy Ansible Vagrant Shims to bin Directory"
	cp -r $HOME/ansible-on-win/ansible-playbook.bat $HOME/ansible/bin/ansible-playbook.bat

    # Copy default config
    cp $ANSIBLE_DIR/examples/ansible.cfg ~/.ansible.cfg
    # Use paramiko to allow passwords
    sed -i 's|#\?transport.*$|transport = paramiko|' ~/.ansible.cfg
    # Disable host key checking for performance
    sed -i 's|#host_key_checking = False|host_key_checking = False|' ~/.ansible.cfg

    BOOTSTRAP_ANSIBLE_UPDATE=1
    #Set this script to run at shell startup
    echo "# If you don't want to update Ansible every time set BOOTSTRAP_ANSIBLE_UPDATE=0" >> $HOME/.zshrc
    echo "export BOOTSTRAP_ANSIBLE_UPDATE=1" >> $HOME/.zshrc
    echo "source $HOME/ansible-on-win/ansible-bootstrap.sh" >> $HOME/.zshrc
    echo " "
    echo "Remember to setup the ssh-agent."
    echo " "
    echo "Please restart MSYS-SHELL!!!!"

    # touch a file to mark first app init completed
    touch /etc/ansible-on-win.installed
fi
