---
layout: post
title: "Http Requests in Coffeescript"
modified:
categories: articles
excerpt:
tags: [coffescript]
image:
  feature:
date: 2014-02-26T15:11:01-03:00
---

Coffescript is quite easy.

The following code shows how to perform an http get request. The script will obtain the string value if exists, and will show an error if the http return code indicates the value doesn't exist.


<code>http_get.coffee </code>

~~~ coffescript
http = require 'http'

component='frontend'
url="http://dev.acme.com/api/conf/key/"+component+"/DEFAULT_DEPLOY_ENV"
console.log url
req = http.get url, (res) ->
  status = res.statusCode
  value = if status == 200 then 1 else 0
  if status == 200
    # ...
    console.log "yey!"
    res.on 'data', (chunk) ->
      console.log('body: ' + chunk)
  else
    # ...
    console.log "i'm not worthy"

req.on 'error', ->
  msg = "not available"
  console.log msg
console.log "done!"
~~~


~~~ sh
osvaldo@laptop:~/ $ coffee http_get.coffee
http://dev.acme.com/api/conf/key/frontend/someenv
done!
i'm not worthy
~~~

~~~ sh
osvaldo@laptop:~/ $ coffee http_get.coffee
http://dev.acme.com/api/conf/key/frontend/prod
done!
yey!
body: prod
~~~

As a bonus note check how the <code>console.log "done!"</code> is executed before displaying the output from the request. That's because of the asynchronous nature from the callback function  handling the request.

