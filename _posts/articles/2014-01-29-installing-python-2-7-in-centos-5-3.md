---
layout: post
title: "Installing Python 2.7 in CentOS 5.3"
modified:
categories: articles
excerpt:
tags: []
image:
  feature:
date: 2014-01-29T10:37:43-03:00
---


Ansible requires python 2.6 or newer.
CentOS 5.3 comes with python 2.4, a version which is used by system tools like yum.
In order to run ansible on older CentOS version, an alternative installation is provided below.
The following commands will install Python 2.7 (check section for requirements below) in the user's directory. No root access is required.


~~~ sh
USER=osvaldo
VERSION=2.7.5
mkdir ~/src
cd ~/src
wget http://python.org/ftp/python/$VERSION/Python-$VERSION.tar.bz2
tar xjf Python-$VERSION.tar.bz2
rm Python-$VERSION.tar.bz2
cd Python-$VERSION
INSTALL_DIR=/home/$USER/bin/python27
mkdir -p $INSTALL_DIR
./configure --prefix=$INSTALL_DIR
make
make install
ln -s $INSTALL_DIR/bin/python27 /home/${USER}/bin/
~~~




#### Requirements

If after the <code>make</code> step the following error appears

~~~ sh
[osvaldo@srv2 Python-2.7.5]$ make
running build
running build_ext
INFO: Can't locate Tcl/Tk libs and/or headers

Python build finished, but the necessary bits to build these modules were not found:
_bsddb             _curses            _curses_panel
_sqlite3           _tkinter           bsddb185
bz2                dbm                gdbm
sunaudiodev
To find the necessary bits, look in setup.py in detect_modules() for the module's name.

running build_scripts
[osvaldo@srv2 Python-2.7.5]$
~~~

The following packages should be installed.

~~~ sh
sudo yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
~~~

#### Post installation

The new binaries should be added to the bin path. This can be done by modifying the <code>~/.bash_profile</code> to look like the following. Remember to start a new session for the change to apply.

~~~ sh
PATH=$PATH:$HOME/bin:$HOME/bin/python/bin
~~~

For example. The following error:

~~~ sh
[osvaldo@srv2 tmp]$ sh setuptools-0.6c11-py2.7.egg --prefix=/home/osvaldo/bin/python
setuptools-0.6c11-py2.7.egg: line 3: exec: python2.7: not found
[osvaldo@srv2 tmp]$
~~~

Can be fixed after adding the python 2.7 binary scripts to the bin path.

~~~ sh
[osvaldo@srv2 tmp]$ sh setuptools-0.6c11-py2.7.egg --prefix=/home/osvaldo/bin/python
Processing setuptools-0.6c11-py2.7.egg
Copying setuptools-0.6c11-py2.7.egg to /home/osvaldo/bin/python27/lib/python2.7/site-packages
Adding setuptools 0.6c11 to easy-install.pth file
Installing easy_install script to /home/osvaldo/bin/python/bin
Installing easy_install-2.7 script to /home/osvaldo/bin/python/bin
Installed /home/osvaldo/bin/python27/lib/python2.7/site-packages/setuptools-0.6c11-py2.7.egg
Processing dependencies for setuptools==0.6c11
Finished processing dependencies for setuptools==0.6c11
[osvaldo@srv2 tmp]$
~~~


