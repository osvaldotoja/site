---
layout: post
title: "Parsing in Coffescript"
modified:
categories: articles
excerpt:
tags: []
image:
  feature:
date: 2014-02-26T15:35:04-03:00
---

Parsing with regex is simple in coffescript. Just use the same syntax as [Javascript](http://www.w3schools.com/jsref/jsref_obj_regexp.asp) as shown below.

More info [here](http://coffeescriptcookbook.com/chapters/regular_expressions/heregexes).

tl;dr

for your copy/paste please, just type the following on a <code>coffee</console>.

~~~ coffeescript
string="wp-theme-acme-2.1.33.zip"
pattern = /^([a-z\-]*)-([\d\.]*).zip/
string.match(pattern)
[component,version] = string.match(pattern)[1...3]
component
version
~~~

Output

~~~ coffeescript
coffee> string="wp-theme-acme-2.1.33.zip"
'wp-theme-acme-2.1.33.zip'
coffee> pattern = /^([a-z\-]*)-([\d\.]*).zip/
/^([a-z\-]*)-([\d\.]*).zip/
coffee> string.match(pattern)
[ 'wp-theme-acme-2.1.33.zip',
  'wp-theme-acme',
  '2.1.33',
  index: 0,
  input: 'wp-theme-acme-2.1.33.zip' ]
coffee>
~~~

We can store the parsed results directly into variables using something like the following.

~~~
[component,version] = string.match(pattern)[1...3]
~~~

Output

~~~ coffeescript
coffee> [component,version] = string.match(pattern)[1...3]
[ 'wp-theme-acme', '2.1.33' ]
coffee> component
'wp-theme-acme'
coffee> version
'2.1.33'
coffee>
~~~
