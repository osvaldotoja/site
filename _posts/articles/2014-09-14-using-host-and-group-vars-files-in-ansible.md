---
layout: post
title: "Organizing Group Vars Files in Ansible"
modified:
categories: articles
excerpt:
tags: [ansible]
image:
  feature:
date: 2014-09-14T22:51:11-03:00
---

from [here](http://docs.ansible.com/intro_inventory.html#splitting-out-host-and-group-specific-data)

In addition to the storing variables directly in the INI file, host and group variables can be stored in individual files relative to the inventory file.

## directory layout
~~~ sh
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

## playbook

~~~ yaml
# group-vars.yml
- hosts: all
  user: osvaldo
  sudo: no
  gather_facts: False

  tasks:
     - debug: msg="reading from {{ env_name }}"
~~~

## files in production directory

inventory

~~~ yaml
# production/inventory
[server]
localhost   ansible_connection=local
~~~

vars

~~~ yaml
# production/group_vars/server.yml
env_name: production
~~~

## files in staging directory

inventory

~~~ yaml
# staging/inventory
[server]
localhost   ansible_connection=local
~~~

vars

~~~ yaml
# staging/group_vars/server
env_name: staging
~~~

## executing the playbook

using data from staging directory

~~~ sh
$ ansible-playbook -i staging group-vars.yml

PLAY [all] ********************************************************************

TASK: [debug msg="reading from {{env_name}}"] *********************************
ok: [localhost] => {
    "msg": "reading from staging"
}

PLAY RECAP ********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
~~~

using data from production directory

~~~ sh
$ ansible-playbook -i production group-vars.yml

PLAY [all] ********************************************************************

TASK: [debug msg="reading from {{env_name}}"] *********************************
ok: [localhost] => {
    "msg": "reading from production"
}

PLAY RECAP ********************************************************************
localhost                  : ok=1    changed=0    unreachable=0    failed=0
~~~

> Interesting fact: <code>ansible-playbook</code> when provided a directory as the inventory, will search by default a file named inventory so no need to specify <code>-i production/inventory</code>, only <code>-i production</code> will work just fine.
