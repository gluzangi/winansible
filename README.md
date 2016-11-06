# Ansible-On-Windows README.md

winAnsible is an attempt to create a self contained Ansible implementation on Windows.

### REQUIREMENTS

winAnsible uses a number of open source projects to work properly:

* [MSYS2] - independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software.
* [pacman] - ported package management system from Archlinux
* [python and python-pip] - Markdown parser done right. Fast and easy to extend.

### Installation

winAnsible requires a preinstallation of [MSYS2](http://msys2.github.io/) to run.

Download and extract the [latest pre-built release](http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20161025.exe).

Install the dependencies and start the terminal.

```sh
$ pacman -Sy base-devel libffi libffi-devel pkg-config gmp gmp-devel openssh openssl openssl-devel git python2 python2-setuptools
$ mkdir /usr/local/src/ ; cd /usr/local/src/ ; wget https://bootstrap.pypa.io/get-pip.py
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
