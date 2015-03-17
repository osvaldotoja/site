---
layout: post
title: "Creating Native Packages the Lazy Way"
modified:
categories: articles
excerpt:
tags: [ fpm, aptly, ansible]
image:
  feature:
date: 2015-03-17T12:01:06-03:00
---

# the chain

Using native packages provides many benefits. However, building native packages is not a simple task. Tools like <code>fpm</code> help getting the job done but still creating the package is only one link on the whole chain. 

The chain starts on the code repositories, where the files to be deployed are stored. For source code files, subversion and git repositories are common choices. Artifactory servers are used by java projects. The first step would be to able to grab the code from any of thouse sources.

To create the packages some data is needed. Metadata like the plattform supported by the files, the version number. Data like the directory where the files will be installed. Actions which might be required to be executed upon installation or removal of the package.

The family of the server will define whether a deb or an rpm file will be created. Both formats should be supported since are the most used and it would not be weird to have only one to migrate to the other one at some point in time.

The final step would be to make available the new package to the servers. Package repositories are used for that purpose. So the package will need to be published. Repositories used to be stored on web server's directories but these days services like Amazon's S3 are used as well.


# the tool

How can we orchestrate the package creation chain? A tool for achieving such goal is described below. It is built on ansible, using fpm as the motor engine, aptly as the publishing media and jenkins for running the show. 

Main features:

* simple. Configuration is done via yaml files.
* modular. New inputs or outputs can be added writing ansible playbooks.
* scalable. Can be used for large number of components.
* convention over configuration.

One of the objectives for this project was not to require any technical knowledge of native package creation in order to use it. All the data required to create the package is stored in one place: the variables files. When a new package is required, just add a new file to the variables directory and it will be ready to be built. If a git repository is used for this project, a PR would be all it needs for a developer to get his code ready for installation using native packages.

The arquitecture is based on the Unix philosophy. Small parts combined to provide the final result. Each step is responsable for one thing only. The input plugins will retrieve the files and place them under a predefined directory. The package's data is defined on variables stored in yaml files. The <code>fpm</code> command is executed with the proper set of variables to create the native package. Once the package was created, the output plugin will publish it to a package repository.

Simplicity does comes at a cost. Use of convention over configuration is mandatory for some of the features of this tool, the use of common variables for instance.

# data

Data is stored in ansible variable files. Packages can be grouped to avoid repeating data. For instance, a web site might have different components: modules, themes (i'm thinking drupal), each one a different package yet all sharing the same document root. A common file can be created for storing such data while keeping info about the components on their specific file. A variable file named <code>all</code> will contain data available to all projects. 

Data can be stored in a hierarchy format composed by three levels where the more granular override the general ones:

* global
* common
* component

There is also data specific for the plugins, which be stored on files <code>input-*</code> and <code>output-*</code> where the plugin name will be part of the filename (e.g. <code>input-git</code> for the git input plugin).

## global

The <code>global</code> level consists of only one file: <code>group_vars/all</code>. This file stores variables shared by all components.

Examples.

Package metadata can be stored on this file. 

{% highlight yaml %}
{% raw %}
# package metadata
pkg_vendor: ACME
pkg_license: Apache Licence
pkg_maintainer: <release-team@acme.com>
{% endraw %}
{% endhighlight %}

Default values for the build process like the directory where the input plugins will store the files for the build process process them.

{% highlight yaml %}
{% raw %}
# fpm temp dir
pkg_tmp_dir: /var/tmp/fpm
{% endraw %}
{% endhighlight %}

Mantainer scripts can be added to the package just by droping the scripts in a predefined folder. Same works for config files like service scripts.
The location of the folder where this files are to be found can be defined at a global level. It is also a good design choice to provide default options or whether to use or not the funcionalities provided by the tool.

{% highlight yaml %}
{% raw %}
# roles/packaging/tasks/pkg-scripts.yml
init_scripts_rootdir: /home/local/git/pkg-scripts/
pkg_scripts_setup: false
pkg_script_opts: --template-scripts
pkg_script_files_opt: { preinst: '--before-install', postinst: '--after-install ', prerm: '--before-remove ', postrm: '--after-remove ' }
fpm_pkg_opts:
# roles/packaging/tasks/pkg-conffiles.yml
pkg_conffiles_setup: false
pkg_conffiles_etcdir: /etc
fpm_scripts_opts:
{% endraw %}
{% endhighlight %}

Any value found on this file will be ovewritten if declared on any of the following levels.

## common

If a project is splited on several packages, chances are they will share some variables, like the document root for web based projects. To avoid repeating data, a file can be created which will be automatically be imported during the build phase. 

{% highlight yaml %}
{% raw %}
pkg:
  rpm:
    base_prefix : /home/httpd/www.acme.com
    user: "--rpm-user httpd"
    group: "--deb-group httpd"
  deb:
    base_prefix : /var/www/www.acme.com
    user: "--deb-user www-data"
    group: "--deb-group www-data"
{% endraw %}
{% endhighlight %}

The common level is composed by files named <code>common-'component-name'</code>. The filename for the common variables is created by parsing the component string: "common-<first word of the component up to the dash sign>". So a component named <code>web-frontend</code> will automatically import the <code>common-web</code> file.

{% highlight yaml %}
{% raw %}
  # extracts the component name up to the first dash
  - name: get common component filename
    set_fact: common_component="{{ component | regex_replace('(.*?)\-.*$', '\\1') }}"

  #" include common if it exists, just continue if not
  - name: include component common vars file 
    include_vars: "group_vars/common-{{ common_component }}"
    ignore_errors: yes
{% endraw %}
{% endhighlight %}

The common file is not mandatory, execution will continue normally if the file is not found.

## component

The variables declared at this level will override any previously declared variable. Because of the way ansible works, there is no merge for variables, it just use the new one. The files at component level will be named after the project's name and stored in the <code>group_vars</code> directory. For a project named web-frontend, the file <code>group_vars/web-frontend</code> will automatically be imported. The execution of the tool will fail if this file is not found.

The component variable file is mandatory, execution will be interrupted if the file is not found.

# input

The input plugins do only one job. To retrieve the files and put them on a folder in the server. Plugins are ansible tasks files available in the <code>packaging</code> role. Each plugin will have the logic for retrieving the files where the development team left them.

The plugin to be used is declared via the <code>component_input</code> variable, usually on the common file: 

group_vars/common-web

{% highlight sh %}
component_input: main_jfrog
{% endhighlight %}

By convention, input variable files will be named: <code>input-'component_input'</code>.

{% highlight yaml %}
{% raw %}
  - name: include component input vars file 
    include_vars: "group_vars/input-{{ component_input }}"
    when: component_input is defined
{% endraw %}
{% endhighlight %}

Although the project can use the same technologies, like artifactory servers or git repositories, different teams might use different servers, which means different access urls, credentials.

The <code>component_input</code> variable will point to an input file where such data is stored. All git related input files will do share one variable in common: <code>input_type: artifact</code>.

{% highlight yaml %}
{% raw %}
# group_vars/web-frontend
component_input: github

# group_vars/web-translations
component_input: gitlab

# group_vars/web-daemon
component_input: main_jfrog

# group_vars/input-github
input_url: git@github.com:acme
input_type: git

# group_vars/input-gitlab
input_url: git@git.acme.com.ar:acme
input_type: git

#group_vars/input-main_jfrog
jfrog_admin_user: admin
jfrog_admin_password: secret
jfrog_url: jfrog.acme.com.ar/artifactory/simple
input_type: artifact
{% endraw %}
{% endhighlight %}

The input variable files will contain specific access data for that component. But all the component stored in a git repository will have the following line: <code>input_type: git</code>. This variable defines the task file to be used on the ansible role <code>packaging</code>.

roles/packaging/tasks/main.yml
{% highlight yaml %}
{% raw %}
- include: git.yml
  when: input_type == 'git'

- include: artifact.yml
  when: input_type == 'artifact'
{% endraw %}
{% endhighlight %}

With this setup, both components: web-frontend and web-translations will download code using the <code>git.yml</code> task file using the corresponding access credentials. 

At the end of this step, the code will reside in a directory, by default: <code>/var/tmp/'component-name'/src</code>.

# build

Once the files had been retrieved and placed in the directory, the time has come for the <code>fpm</code> command to be executed. Mantainer scripts and rcconf files are added if required.

{% highlight yaml %}
{% raw %}
- include: pkg-scripts.yml
  when: pkg_scripts_setup

- include: pkg-conffiles.yml
  when: pkg_conffiles_setup
{% endraw %}
{% endhighlight %}

The actual execution of the <code>fpm</code> command was moved to the next step to handle the creation and publishing of the package in the same task file.

# output

The output plugin to be used is selected via a similar procedure to the one used by the input plugins.

{% highlight yaml %}
{% raw %}
  # output
  - name: include component input vars file 
    include_vars: "group_vars/output-{{ component_output }}"
    when: component_output is defined
    ignore_errors: yes
{% endraw %}
{% endhighlight %}

There are way too many variables to take into consideration when creating native packages. Just using ansible to ease the handling of variables passed as command line options to the <code>fpm</code> would had worth the effort.

Here we create the native package, grab the name (parsing fpm's output) and notify the availability via a hipchat channel.

{% highlight yaml %}
{% raw %}
- name: deb -  creating package with fpm 
  command: 'fpm -t deb -s {{ pkg_input_type }} --name {{ component_package_name_prefix }}-{{ component_package_name }} --version {{ version }} --iteration {{ branch }}-{{ sha }}-{{ iter }} --architecture {{ component_arch }}  --maintainer "{{ pkg_maintainer }}" --description "{{ component_description }}" --url {{ component_uri }} --vendor {{ pkg_vendor }} --license "{{ pkg_license }}" {{ pkg.deb.user }} {{ pkg.deb.group }} {{ fpm_scripts_opts }} -C src/ . chdir={{ pkg_tmp_dir }}/{{ component }} '
  register: out

- name: deb -  get package name
  set_fact: pkgfile={{ out.stdout_lines[0] | regex_replace('.*path=>"(.*\.deb).*$', '\\1') }}
- debug: var=pkgfile
- hipchat_v2: msg="new package created {{ pkgfile }}" color="{{ pkg_hipchat_color }}" room="{{ pkg_hipchat_room }}" token="{{ pkg_hipchat_token }}"
{% endraw %}
{% endhighlight %}

Debian repositories only make available the latest version of a package. This is a problem for development environments when a rollback to a previous version is always an option. [Aptly](http://www.aptly.info/) is a tool for managing Debian repositories.

Aptly works in two steps:

* first the package is added to the aptly internal repository
* then the package is published on a Debian repository (local or on S3).

For this setup, the code's branch is used to decide on which internal aptly repo the package will be added. A package can be published to one or more debian repositories.

{% highlight yaml %}
{% raw %}
# main apt repository (aptly)
- name: deb -  adding package to repository
  command: aptly repo add {{ item.repo }} {{ pkg_tmp_dir }}/{{ component }}/{{ pkgfile }}
  with_items: "component_package_publish.branch.{{ yaml_branch }}.aptly"
  when: "'main_apt' in component_publish_target"

- name: deb -  update repository
  command: "aptly publish update  {{ item.distribution }}  {{ item.endpoint }}"
  with_items: "component_package_publish.branch.{{ yaml_branch }}.aptly"
  when: "'main_apt' in component_publish_target"
{% endraw %}
{% endhighlight %}


# ansible

Ansible is responsable for orquestrating the creation of the package. Providing the variables, executing the <code>fpm</code> command with the right options and publishing the package to the debian repository.

Execution is done via the following command

{% highlight yaml %}
{% raw %}
 ansible-playbook -i inventory main.yml -e "component=web-modules version=1.0.2 branch=master sha=646a561"
{% endraw %}
{% endhighlight %}


{% highlight yaml %}
{% raw %}
├── group_vars
│   ├── all
│   ├── backend-daemon
│   ├── common-web
│   ├── languages
│   ├── web-modules
│   └── web-themes
├── inventory
├── main.yml
└── roles
    └── packaging
        ├── defaults
        │   └── main.yml
        └── tasks
            ├── artifact.yml
            ├── deb.yml
            ├── git.yml
            ├── main.yml
            ├── pkg-conffiles.yml
            ├── pkg-scripts.yml
            └── svn.yml
{% endraw %}
{% endhighlight %}

