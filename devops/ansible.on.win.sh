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
#:: There are 54 members in group base-devel:
#:: Repository msys
#   1) asciidoc  2) autoconf  3) autoconf2.13  4) autogen  5) automake-wrapper  6) automake1.10  7) automake1.11  8) automake1.12  9) automake1.13  10) automake1.14  11) automake1.15
#   12) automake1.6  13) automake1.7  14) automake1.8  15) automake1.9  16) bison  17) diffstat  18) diffutils  19) dos2unix  20) file  21) flex  22) gawk  23) gdb  24) gettext
#   25) gettext-devel  26) gperf  27) grep  28) groff  29) help2man  30) intltool  31) lemon  32) libtool  33) libunrar  34) m4  35) make  36) man-db  37) pacman  38) pactoys-git  39) patch
#   40) patchutils  41) perl  42) pkg-config  43) pkgfile  44) quilt  45) rcs  46) scons  47) sed  48) swig  49) texinfo  50) texinfo-tex  51) ttyrec  52) unrar  53) wget  54) xmlto

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
     #git pull --rebase
     #git submodule update --init --recursive
    fi
    #source ./hacking/env-setup
    cd $CURRENT_DIR

	echo "Update Ansible Vagrant Shims in bin Directory"
	#cp -r $HOME/ansible-on-win/ansible-playbook.bat $HOME/ansible/bin/ansible-playbook.bat

    echo "Remember to setup the ssh-agent."

  else
    #Replace babun sudo with new fake sudo for Ansible, throwing way all sudo args.
    #echo "#!/usr/bin/env bash" > /usr/bin/sudo
    #echo "count=0" >> /usr/bin/sudo
    #echo "for var in "$@"" >> /usr/bin/sudo
    #echo "  do" >> /usr/bin/sudo
    #echo "    (( count++ ))" >> /usr/bin/sudo
    #echo "  done" >> /usr/bin/sudo
    #echo "shift $count" >> /usr/bin/sudo
    #echo "exec "$@"" >> /usr/bin/sudo

    ##
    # Install Ansible On Windows Packages To Resolve Library Dependencies
    ##
    pacman -Sy pacman
    pacman -Syu base-devel curl libffi libffi-devel gmp gmp-devel openssh openssl openssl-devel git python2 python2-setuptools

    ##
    # Fetch Ansible On Windows Related Fixes From The Repo
    ##
    git clone https://gitlab.com/gluzangi/winansible.git $HOME/
    cp $HOME/devops/ansible.localhost/roles/box/files/pyconfig.h /usr/include/python2.7/pyconfig.h

    ###
    # Install Python PIP
    ###
    curl https://bootstrap.pypa.io/get-pip.py | python

    ###
    # Use PIP to install Ansible And Automatically Resolve Dependencies
    ###
    pip install -U -r $HOME/devops/ansible.pip.requirements.txt
    ansible --version

    #Create initial Ansible hosts inventory
    #mkdir -p /etc/ansible/
    #echo "127.0.0.1" > /etc/ansible/hosts
    #chmod -x /etc/ansible/hosts

    #Setup Ansible from Source
    #mkdir -p $ANSIBLE_DIR
    #git clone git://github.com/ansible/ansible.git --recursive $ANSIBLE_DIR
    #cd $ANSIBLE_DIR
    #source ./hacking/env-setup
    #cd $CURRENT_DIR

	#echo "Copy Ansible Vagrant Shims to bin Directory"
	#cp -r $HOME/ansible-on-win/ansible-playbook.bat $HOME/ansible/bin/ansible-playbook.bat

    # Copy default config
    #cp $ANSIBLE_DIR/examples/ansible.cfg ~/.ansible.cfg
    # Use paramiko to allow passwords
    #sed -i 's|#\?transport.*$|transport = paramiko|' ~/.ansible.cfg
    # Disable host key checking for performance
    #sed -i 's|#host_key_checking = False|host_key_checking = False|' ~/.ansible.cfg

    BOOTSTRAP_ANSIBLE_UPDATE=1
    #Set this script to run at shell startup
    #echo "# If you don't want to update Ansible every time set BOOTSTRAP_ANSIBLE_UPDATE=0" >> $HOME/.zshrc
    #echo "export BOOTSTRAP_ANSIBLE_UPDATE=1" >> $HOME/.zshrc
    #echo "source $HOME/ansible-on-win/ansible-bootstrap.sh" >> $HOME/.zshrc
    #echo " "
    #echo "Remember to setup the ssh-agent."
    #echo " "
    #echo "Please restart MSYS-SHELL!!!!"

    # touch a file to mark first app init completed
    #touch /etc/ansible-on-win.installed
fi
