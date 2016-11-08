#!/usr/bin/env bash

#########
#
#  ANSIBLE ON WINDOWS SCRIPT TASKS:-
#
#  STEP 1: Check Out A Fresh Copy Of winAnsible.git
#  STEP 2: $HOME/ansible-on-win.sh
#  STEP 3: Add Ansible Building Tools
#  STEP 4: Install Python-pip
#  STEP 5: Install Ansible Using Pip
#
#######

ANSIBLE_DIR=$HOME/.ansible

CURRENT_DIR=$(pwd)

if [[ -f !'/etc/ansible-on-win.installed' ]]; then
    echo "Init Ansible On Win Update."
#    cd $ANSIBLE_DIR
#    if [[ $BOOTSTRAP_ANSIBLE_UPDATE = 1 ]];then
#     echo "Performing Ansible update from source, if available."
#    fi
#    #source ./hacking/env-setup
#    cd $CURRENT_DIR

    echo " "
    echo "Ansible-On-Windows Upgrade Completed."
    echo "Remember to setup the ssh-agent."
else
    ##
    # Fetch Ansible On Windows From The Repo
    ##
    # git clone https://gitlab.com/gluzangi/winansible.git $HOME/winAnsible

    ##
    # Prepare Ansible On Windows Building Tools
    ##
    pacman -Sy --noconfirm pacman
    pacman -Syu --noconfirm base-devel python2 python2-setuptools curl libffi libffi-devel gmp gmp-devel openssl openssl-devel git

    ##
    # Fix Python Building Environment
    ##
    echo ">> Fix pyconfig.h First..."
    cp $HOME/winAnsible/ansible.playbook/roles/box/files/pyconfig.h /usr/include/python2.7/pyconfig.h

    ###
    # Install Python PIP
    ###
    curl https://bootstrap.pypa.io/get-pip.py | python

    ###
    # Use PIP To Install Ansible And Automatically Resolve Dependencies
    ###
    pip install -U -r $HOME/winAnsible/ansible.pip.requirements.txt
    ansible --version

    ###
    # Set Ansible-On-Window Status
    ###
    BOOTSTRAP_ANSIBLE_UPDATE=1
    echo '1' > /etc/ansible-on-win.installed

    #Set this script to run at shell startup
    #echo "# If you don't want to update Ansible every time set BOOTSTRAP_ANSIBLE_UPDATE=0" >> $HOME/.bashshrc
    #echo "export BOOTSTRAP_ANSIBLE_UPDATE=1" >> $HOME/.zshrc
    #echo "source $HOME/ansible-on-win/ansible-bootstrap.sh" >> $HOME/.zshrc

    echo " "
    echo "Ansible-On-Windows Install Completed."
    echo "Remember to setup the ssh-agent."
fi
