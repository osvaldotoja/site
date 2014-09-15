---
layout: post
title: "Install Ansible in CentOS 5.3"
modified:
categories: articles
excerpt:
tags: []
image:
  feature:
date: 2014-09-14T22:50:52-03:00
---


install-ansible-in-centos-5-3

30 Jan 14 @ 14:48

Using ansible in CentOS 5.3 can be done via a handful of simple steps.

#### Installation

First we install python modules. Ansible is available via package managers but not for CentOS 5.3 so a git based installation will be used.

~~~ sh
/home/rls/bin/python/bin/pip install paramiko PyYAML jinja2 httplib2
cd ~/bin
git clone git://github.com/ansible/ansible.git
sed -i '1 s/python$/python2.7/' ansible/bin/ansible*
~~~

After cloning the repository, the binary scripts are modified in order to use our custom python 2.7 installation.

#### Test installation


~~~ sh
source bin/ansible/hacking/env-setup
echo "127.0.0.1 ansible_python_interpreter=/home/rls/bin/python/bin/python2.7  ansible_connection=local" > ~/ansible_hosts
export ANSIBLE_HOSTS=~/ansible_hosts
ansible -i ~/ansible_hosts all -m ping
~~~

expected output:

~~~ sh

[osvaldo@srv2 ~]$ ansible -i ~/ansible_hosts all -m ping  -o
127.0.0.1 | success >> {"changed": false, "ping": "pong"}

[osvaldo@srv2 ~]$
~~~

#### Post installation steps

Add to <code>~/.bash_profile</code> the following line.

~~~ sh
source bin/ansible/hacking/env-setup
~~~
