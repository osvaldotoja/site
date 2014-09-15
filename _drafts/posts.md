---
layout: post
title: "borradores"
modified:
categories:
excerpt:
tags: [git]
image:
  feature:
date: 2014-03-12T21:15:58-03:00
---


===



===

using group_vars in ansible
draft


~~~ sh
# group_vars/coyote.yml
name:
  - coyote
~~~

~~~ sh
#  group_vars/roadrunner.yml
name:
  - roadrunner
~~~

~~~ sh
osvaldo@acme:~/playbooks$ ansible-playbook -i hosts vars.yml --extra-vars "app=coyote"

PLAY [all] ********************************************************************

TASK: [debug msg="coyote"] ****************************************************
ok: [localhost] => {
    "msg": "coyote"
}

TASK: [debug msg="['coyote']"] ************************************************
ok: [localhost] => {
    "msg": "['coyote']"
}

PLAY RECAP ********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0

osvaldo@acme:~/playbooks$
~~~


===

using host and group vars files in ansible


http://docs.ansible.com/intro_inventory.html#splitting-out-host-and-group-specific-data

In addition to the storing variables directly in the INI file, host and group variables can be stored in individual files relative to the inventory file.

~~~
production/
├── group_vars
│   └── server.yml
└── inventory
staging/
├── group_vars
│   └── server
└── inventory
group-vars.yml
~~~

~~~
# group-vars.yml
- hosts: all
  user: osvaldo
  sudo: no
  gather_facts: False

  tasks:
     - debug: msg="reading from {{ env_name }}"
~~~

~~~
# production/inventory
[server]
localhost   ansible_connection=local
~~~

~~~
# production/group_vars/server.yml
env_name: production
~~~

~~~
# staging/inventory
[server]
localhost   ansible_connection=local
~~~

~~~
# staging/group_vars/server
env_name: staging
~~~

~~~
$ ansible-playbook -i staging group-vars.yml

PLAY [all] ********************************************************************

TASK: [debug msg="reading from {{env_name}}"] *********************************
ok: [localhost] => {
    "msg": "reading from staging"
}

PLAY RECAP ********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
~~~


~~~
$ ansible-playbook -i production group-vars.yml

PLAY [all] ********************************************************************

TASK: [debug msg="reading from {{env_name}}"] *********************************
ok: [localhost] => {
    "msg": "reading from production"
}

PLAY RECAP ********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
~~~

same happens for hosts

~~~
# host_vars/localhost
env_name: localhost_environment
~~~

~~~
# inventory
[server1]
localhost
~~~

~~~
# localhost-vars.yml
- hosts: server1
  user: osvaldo
  sudo: no
  gather_facts: False

  tasks:
     - debug: msg="reading from {{ env_name }}"
~~~

output

~~~
$ ansible-playbook -i inventory server1-vars.yml

PLAY [server1] ****************************************************************

TASK: [debug msg="reading from {{env_name}}"] *********************************
ok: [localhost] => {
    "msg": "reading from localhost_environment"
}

PLAY RECAP ********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
~~~

===
