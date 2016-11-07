# Ansible-On-Windows

__winAnsible__ is an attempt to create an automated Ansible on Windows installer to an experimental Ansible implementation on Windows. In the meantime, the entire manual process to natively run Ansible-On-Windows is distilled over the following steps.

## REQUIREMENTS

To port Ansible and make it run on Windows requires a number of tools to create the appropriate build environment to work with :

* __MSYS2__ - independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software.
* __git__ - distributed revision control system aimed at speed,data integrity,and support for distributed, non-linear workflows.
* __pacman__ - ported package management system from Archlinux
* __python and python-pip__ - Python programming language, use pip to install and manage software packages written in Python.

#### Porting To Windows Environment Preparation

1. __winAnsible__ will require a preinstallation of [MSYS2](http://msys2.github.io/) to run.

2. Download and extract the [latest pre-built release](http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20161025.exe).

3. Start the MSYS2 terminal.

##### Installation Restrictions:
+ MSYS2 can't be installed on FAT* partitions.
+ Current MSYS2 can't be installed on Windows XP anymore.
+ To install Ansible atop __Git-For-Windows__ would require [Git-For-Windows SDK](https://github.com/git-for-windows/build-extra/releases) to expose pacman tool. 

#### Difference between MSYS2 and MinGW
>MSYS2 refers to the libraries and programs that use the POSIX emulation layer ("msys2 runtime", derived from Cygwin's cygwin1.dll). It is very easy to port libraries and programs from Unix/Linux because most of the POSIX semantics is emulated reasonably well, for example the fork() function. Bash and Perl are examples of MSYS2 programs.


>MinGW refers to libraries and programs that are compiled using GNU tools but do not require any POSIX semantics, instead relying on the standard Win32 API and the C runtime library. MinGW stands for "Minimal GNU for Windows". Examples: cURL (a library to talk to remote servers via HTTP(S), (S)FTP, etc), emacs, Inkscape, etc


>The POSIX emulation layer of MSYS2 binaries is convenient, but comes at a cost: Typically, MSYS2 programs are noticably slower than their MinGW counterparts (if there are such counterparts). As a consequence, the Git for Windows project tries to provide as many components as possible as MinGW binaries.

## Ansible On Windows Installation

```sh
$ pacman -Sy pacman
$ pacman -Syu base-devel libffi libffi-devel pkg-config gmp gmp-devel openssh openssl openssl-devel git python2 python2-setuptools
$ git clone https://gitlab.com/gluzangi/winansible.git $HOME/
$ cp $HOME/devops/ansible.localhost/roles/box/files/pyconfig.h /usr/include/python2.7/pyconfig.h
$ curl https://bootstrap.pypa.io/get-pip.py | python
$ pip install -U -r $HOME/devops/ansible.pip.requirements.txt
$ ansible --version
```
##### Known Ansible Limitation:
Mostly are SSH related features that have been observed to be missing (or need a workaround)
+  `ControlPath` to store the “control socket” for the multiplexed connections.
+  `ControlMaster` to activate multiplexing. SSH will try to use a master connection if one exists.
+  `ControlPersist` to keep the master connection alive for the specified period of time after it has remained idle (no connections). After that time, the master connection will be closed.
+ `ln -s TARGET LINK_NAME` symlinks creation command don't seem to work on MSYS2.

## For Production Environments
_A Windows Installer with automated script to prepare **ALL** required packages to complete a fully functional Ansible-On-Windows install_

## Todos

 - Complete Ansible install automation as a script ansible-on-win.sh
 - Reaserch on InstallForge and alternatives for Windows Software Packaging
 - [Git-On-Windows Installer Generator](https://github.com/git-for-windows/build-extra)
 - Rethink Github Repos
 - Add Code Comments

## Ansible-On-Windows References

- [How MSYS2 Differs From Cygwin](https://sourceforge.net/p/msys2/wiki/How%20does%20MSYS2%20differ%20from%20Cygwin/)
- [Running Ansible On Windows](http://www.jeffgeerling.com/blog/running-ansible-within-windows)
- [Babun - A Windows Shell ](http://babun.github.io/index.html)
- [Ansible Running On Babun](https://github.com/tiangolo/ansible-babun-bootstrap)
- [Install Python Packages Using PIP](https://pip.pypa.io/en/stable/reference/pip_install/#requirement-specifiers)


License
----

MIT or GPL


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [gluzangi]: <https://github.com/gluzangi>
   [gitlab-repo]: <https://gitlab.com/gluzangi/winansible>
   [Python-pip]: <https://packaging.python.org/installing/#installing-from-pypi>
   [InstallForge]: <http://www.installforge.net/>
