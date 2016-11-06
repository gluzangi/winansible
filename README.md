# Ansible-On-Windows README.md

winAnsible is an attempt to create a Windows MSI package to an experimental Ansible implementation on Windows.

### REQUIREMENTS

winAnsible uses a number of open source projects to work properly:

* [MSYS2] - independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software.
* [git] - distributed revision control system aimed at speed,data integrity,and support for distributed, non-linear workflows.
* [pacman] - ported package management system from Archlinux
* [python and python-pip] - Python programming language and pip in order to install Python packages from PyPI.

### Installation

winAnsible requires a preinstallation of [MSYS2](http://msys2.github.io/) to run.

Download and extract the [latest pre-built release](http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20161025.exe).

Install the dependencies and start the terminal.

```sh
$ pacman -Sy base-devel libffi libffi-devel pkg-config gmp gmp-devel openssh openssl openssl-devel git python2 python2-setuptools
$ git clone https://gitlab.com/gluzangi/winansible.git $HOME/
$ cp $HOME/devops/ansible.localhost/roles/box/files/pyconfig.h /usr/include/python2.7/pyconfig.h
$ mkdir /usr/local/src/ ; cd /usr/local/src/ ; wget https://bootstrap.pypa.io/get-pip.py ; python get-pip.py
$ pip install -U -r $HOME/devops/ansible.pip.requirements.txt
$ ansible --version
```

For production environments...

### Todos

 - Write Tests
 - Rethink Github Save
 - Add Code Comments
 - Add Night Mode

License
----

MIT or GPL


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [gluzangi]: <https://github.com/gluzangi>
   [gitlab-repo]: <https://gitlab.com/gluzangi/winansible>
   [Python-pip]: <https://packaging.python.org/installing/#installing-from-pypi>
