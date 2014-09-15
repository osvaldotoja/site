---
layout: post
title: "Previewing Ghost 0.4"
modified:
categories: articles
excerpt:
tags: []
image:
  feature:
date: 2014-01-11T16:56:40-03:00
---


~~~ sh

https://ghost.org/download/

git clone git@github.com:TryGhost/Ghost.git
cd Ghost
git submodule update --init
bundle install
sudo npm install -g grunt-cli
npm install
grunt init
npm start

# Front-end will be accesible at http://localhost:2368, Admin is at http://localhost:2368/ghost/.


# buster

pip install buster
buster --version
buster setup

buster generate --domain=http://127.0.0.1:2368
buster preview
buster deploy

# nice! .... (no hice el setup)
~~~
