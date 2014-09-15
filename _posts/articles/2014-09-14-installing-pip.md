---
layout: post
title: "Installing Pip"
modified:
categories: articles
excerpt:
tags: [python,pip]
image:
  feature:
date: 2014-01-30T14:19:49-03:00
---


Installation of pip will be done via <code>easy_install</code>, a command provided by the setuptools package.


~~~ sh
cd /var/tmp
wget http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg --no-check-certificate
sh setuptools-0.6c11-py2.7.egg --prefix=/home/osvaldo/bin/python
/home/osvaldo/bin/python/bin/easy_install-2.7 pip
~~~

requires previous [python 2.7 installation](/installing-python-2-7-in-centos-5-3/)


