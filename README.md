# Ansible-On-Windows README.md

winAnsible is an attempt to create a Windows MSI package to an experimental Ansible implementation on Windows.

### REQUIREMENTS

winAnsible uses a number of open source projects to work properly:

* [MSYS2] - independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software.
* [git] - distributed revision control system aimed at speed,data integrity,and support for distributed, non-linear workflows.
* [pacman] - ported package management system from Archlinux
* [python and python-pip] - Python programming language, use pip to install and manage software packages written in Python.

### Installation

winAnsible requires a preinstallation of [MSYS2](http://msys2.github.io/) to run.

Download and extract the [latest pre-built release](http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20161025.exe).

Install the dependencies and start the terminal.

Installation restrictions:
+ MSYS2 can't be installed on FAT* partitions.
+ Current MSYS2 can't be installed on Windows XP anymore.

### Difference between MSYS2 and MinGW
* MSYS2 refers to the libraries and programs that use the POSIX emulation layer ("msys2 runtime", derived from Cygwin's cygwin1.dll). It is very easy to port libraries and programs from Unix/Linux because most of the POSIX semantics is emulated reasonably well, for example the fork() function. Bash and Perl are examples of MSYS2 programs.

* MinGW refers to libraries and programs that are compiled using GNU tools but do not require any POSIX semantics, instead relying on the standard Win32 API and the C runtime library. MinGW stands for "Minimal GNU for Windows". Examples: cURL (a library to talk to remote servers via HTTP(S), (S)FTP, etc), emacs, Inkscape, etc

* The POSIX emulation layer of MSYS2 binaries is convenient, but comes at a cost: Typically, MSYS2 programs are noticably slower than their MinGW counterparts (if there are such counterparts). As a consequence, the Git for Windows project tries to provide as many components as possible as MinGW binaries.

```sh
$ pacman -Sy pacman
$ pacman -Syu base-devel libffi libffi-devel pkg-config gmp gmp-devel openssh openssl openssl-devel git python2 python2-setuptools
$ git clone https://gitlab.com/gluzangi/winansible.git $HOME/
$ cp $HOME/devops/ansible.localhost/roles/box/files/pyconfig.h /usr/include/python2.7/pyconfig.h
$ curl https://bootstrap.pypa.io/get-pip.py | python
$ pip install -U -r $HOME/devops/ansible.pip.requirements.txt
$ ansible --version
```

For production environments...

### Todos

 - Complete Ansible install automation as a script ansible-on-win.sh
 - Reaserch on InstallForge and alternatives for Windows Software Packaging
 - [Git-On-Windows Installer Generator](https://github.com/git-for-windows/build-extra)
 - Rethink Github Repos
 - Add Code Comments

License
----

MIT or GPL


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [gluzangi]: <https://github.com/gluzangi>
   [gitlab-repo]: <https://gitlab.com/gluzangi/winansible>
   [Python-pip]: <https://packaging.python.org/installing/#installing-from-pypi>
   [InstallForge]: <http://www.installforge.net/>
