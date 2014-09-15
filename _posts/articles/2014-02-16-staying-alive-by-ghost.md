---
layout: post
title: "'Staying Alive' by Ghost"
modified:
categories: articles
excerpt:
tags: [ghost, nodejs]
image:
  feature:
date: 2014-02-06T14:15:55-03:00
---


This site was meant to be an static site (generated, of course). However, I found some issues with the generated site (links pointing to folder/index.html instead of just folder/) so the decision to run it behind an nginx server was made.

Today ghost crashed:

~~~ sh
/var/www/ghost/toja.io/node_modules/express-hbs/node_modules/handlebars/dist/cjs/handlebars/compiler/compiler.js:444
    throw new Exception("You must pass a string or Handlebars AST to Handlebar"
~~~

Luckily there're a couple of options: supervisord, init scripts and forever. Being this a temporary setup (the static site version is the ultimate goal remember?) the third option was choosen.

[forever]( https://github.com/nodejitsu/forever)  can be used to run Ghost as a background task. forever will restart the node process if it crashes.

Installation is simple:

~~~ sh
sudo npm -g install forever
~~~


Being temporary doesn't means it should run without leaving any track. Forever allows you to use a log file. Since the daemon will be running under a non-root account a directory was created, owned by the same user the script will be executed.


~~~ sh
sudo mkdir /var/www/ghost/logs/
sudo chown osvaldo:osvaldo /var/www/ghost/logs/
~~~


By default, forever will start ghots in development mode. To start Ghost in production mode type <code>NODE_ENV=production forever start index.js</code>
The command should be run from the ghost installation directory.

~~~ sh
cd /var/www/ghost/toja.io/
forever -l /var/www/ghost/logs/toja-io.log start index.js
~~~

To check if Ghost is currently running type <code>forever list</code>


~~~ sh
osvaldo@li68-220:~$ forever list
info:    Forever processes running
data:        uid  command             script   forever pid   logfile                         uptime
data:    [0] mnz9 /usr/local/bin/node index.js 20031   20033 /var/www/ghost/logs/toja-io.log 0:0:1:26.478
osvaldo@li68-220:~$
~~~

To stop Ghost type <code>forever stop index.js</code>

