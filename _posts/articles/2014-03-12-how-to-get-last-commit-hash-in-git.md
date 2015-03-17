---
layout: post
title: "How to Get Last Commit Hash in Git"
modified:
categories:
excerpt:
tags: [git]
image:
  feature:
date: 2014-03-12T21:15:58-03:00
---

The bash way

~~~ sh
$ git log -n1 | grep commit | awk '{print $2}'
fc77768a4f7c460be765012c9a04e9645e4520d2
~~~

The git way

~~~ sh
# short - using h
$ git log --pretty=format:'%h' -n 1
fc77768
# long - using H
$ git log --pretty=format:'%H' -n 1
fc77768a4f7c460be765012c9a04e9645e4520d2
~~~

You can specify the number of digits of the hash using <code>--abbrev=n</code>

~~~ sh
$ git show --pretty=%h --abbrev=18
fc77768a4f7c460be7
~~~
