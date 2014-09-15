---
layout: post
title: "Using Logstash for Artifactory Notifications"
modified:
categories: articles
excerpt:
tags: [logstash, jfrog, elasticsearch]
image:
  feature:
date: 2014-02-16T16:44:58-03:00
---


One of the limitations for the opensource version of [Artifactory's jfrog](http://www.jfrog.com/home/v_artifactory_opensource_overview) is notifications for newly added artifacts. We will provide a workaround to that issue.

Being an app running inside a tomcat container, a  quick inspection on the log file revealed new artifacts creation was being logged in. Below it's an example taken from the log file.

~~~ sh
2014-02-06 14:13:47,259 [art-exec-3091] [INFO ] (o.a.s.a.ArchiveIndexer:102) - The content of the archive: 'acme-alfa-3.4.5.zip' was indexed successfully.
2014-02-06 14:19:45,870 [art-exec-3094] [INFO ] (o.a.s.a.ArchiveIndexer:102) - The content of the archive: 'acme-beta-3.4.1.zip' was indexed successfully.
~~~

A simple solution would had been using a <code>tail -f .. | some_parsing_script.sh</code>. But that would had implied taking care of the persistance of the script (screen is not _that_ good). So the search for a generic solution begins.

Being familiar with logstash it was just a matter of taking a quick look at the documentation and writing down a simple configuration file.

The configuration files contains three sections:

* input. where you declare the source of the logs. here we're using a file, the path for the log file and a plus advantage is the support for log files created by commonly used services like tomcat.
* filter. where we declare the parsing logic, for now, just standard regex parse.
* output. whenever the filter matches the declared string on this section, an execution will occured. here we send a notification to IRC (via hubot) and execute an ansible playbook on a remote server via ssh.


~~~ conf
input {
  file {
    type => "tomcat"
    path => "/var/log/artifactory/catalina/catalina.out"

  }


}
filter {
   grok {
     match => [ "message", "^%{TIMESTAMP_ISO8601:date},%{NUMBER:number}%{GREEDYDATA:data1}The content of the archive: '%{DATA:artifact}'%{GREEDYDATA:data}" ]
   }
}

output {
  if [data] =~ "successfully.$" {
    exec {
      command => "curl -s -H 'Host: hubot.acme.com' 'http://10.1.0.10/message/create?room=%23hubot&text=new%20artifact:%20'%{artifact}"
    }
    exec {
      command => "ssh srv9 /home/bofh/ansible/deploy-pkg.sh %{artifact} prod"
    }
  }

}
~~~
