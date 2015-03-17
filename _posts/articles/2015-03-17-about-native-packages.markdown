---
layout: post
title: "About Native Packages"
modified:
categories: articles
excerpt:
tags: []
image:
  feature:
date: 2015-03-17T11:50:04-03:00
---

# Code

It all started with a developer writing the code. Once it's finished, how can we use that code? Code runs on servers, so what we do with code? Deploy it on servers!  But it's not that simple: lots of code runs on servers. 

# Servers
  
Let's talk a bit about servers. Servers are like apartment buildings, not houses. If you and your neighbor, you both live in houses with three or more floors, each house could have its own elevator. But if you live in a apartment building, chances are you and your neighbor, both share the same and one elevator. The point is, there are facilities on buildings which are shared by all of the residents.

> it can also be said: servers are like cattle, not pets. but that wasn't the topic at hand ;)

Same way, in servers, where lots of process live, there are facilities which were created in order to ease the operations of the server and the services running on top of it. Logs for example. Instead of having to write the code which will handle the creation, rotation, maintenace, etc of log files, there is a facility provided by the server OS providing that service. The code use that facility when it needs to log anything, a system call is all it takes. The OS will take care of the rest (syslog on unix systems, event viewer on windows).


A similar solution was created in order to deploy code on servers but more on that in a moment.


# Artifacts

We were talking about getting the code into servers. So, how we deploy the code on the servers? 

In the beginings:  tgz files (a winzip unix equivalent).  The code was packed on a zipped file, copied to the server, unpacked and if required, moved to the proper directory. 

> Those zipped files ready for deployments are also known as artifacts.

A simple process for installing the artifacts but not without problems: 

* dependencies 
* tracking 
* auditing 
* versioning 
* upgrade 
* rollback 

What if a component depends on another one? You can't define that in zip files.
How to keep record of installation of new packages? Writing custom scripts, yeap, been there, avoid that.
How to know if the files on the directories were locally modified after deployment? Unpacking the original file in another directory and run a comparisson.
How to handle upgrades? What if the new version deprecated a file? You will need to delete it (which is not that hard, but remember to do it, it is).
What if something went wrong and you need to rollback? Download the previous version file, unpack, restore it. Not that bad but time consuming it is (did i mentioned it was a rollback?)

If you're using artifacts, you might had faced this kind of problems. If you're using git based deployments you might not had had most of those issues, but then, you might have a different set of problems like deploying the code to fresh servers (when the .git folder containing commit history is heavier than the actual code size, and it will take longer as the repo grows). Although that's not the main issue with git based deployments, what if the code needs to be placed. Or  on  different directories in the filesystem, for each directory on the same root dir. Not good.

# Native packages

Lucky us working with linux, since 1998 a (by then small) company came up with a solution, a [tool](http://magazine.redhat.com/2007/02/08/the-story-of-rpm/) for solving all of those problems, The tool was called rpm and the company name was Red Hat (rpm stands for RedHat Package Manager).

Files were packed in one rpm file and installed using the (surprise) the <code>rpm</code> command. An rpm package contains no only the files to be deployed but also provides metadata about the package and even the chance to execute commands during the installation (or removal) process.

This is not a Red Hat exclusive, Debian created its own package manager: <code>apt-get</code> command for <code>.deb</code> files. Microsoft users will be familiar with <code>.msi</code> files and so on. All of this files are called native packages because they are created fo an specific plattform.  You will be stopped if you try to install a 32bit package on a 64bit plattform. Packages are created not only for an specific OS but most of the time, can only be installed on specific versions of the OS. 

> OS in the context refers to OS family, like Debian and Ubuntu or Red Hat and CentOS.

Benefits of native packages:

* Dependencies 
* Tracking 
* auditing 
* versioning 
* upgrade 
* rollback 
* Conf files (init scripts, logrotate conf, ...) 
* Scripts ([[pre|post]|[inst|rem]] (create log dirs, app dirs, users) 

* command line tools 
* repositories 

Those issues we had with zipped files, are now benefits. You can declare dependencies between packages on the file's metadata. The command will enforce (and automatically resolve) those dependencies. The tools (whether <code>rpm</code> or <code>apt-get</code>) keep a log of actions (using the shared facility) so events can be tracked, all done by the system with no scripting from our side. The tools allow us to check available or installed versions. Upgrade can be done by running a single command, to the latest or to an specific version. Rolling back is as simple as declaring a previous version when installing a package.

Besides, native packages can be instructed to executed certain actions, like creating or removing a user, a folder, or managing services. This actions will be declared for each of the following four states:

* before the installation
* after the installation
* before the removal
* after the removal

Native packages provide special handling for configuration files, those which usually reside on the <code>/etc</code> directory (like init scripts).
But there's more. You can't install the same file from two packages (try one zip file's content not to overwrite another's one). Want to know which package certain file came from? no problem. Some examples are presented below (debian/ubuntu):

{% highlight sh %}
{% raw %}
How to check metadata for a package:
# apt-cache info <package-name>
How to install a package:
# apt-get install <package-name> 
How to find a package: 
# apt-cache search <pkg-name> 
Which files were installed by a package 
# dpkg -L <package-name>
Wich package installed that file? 
# dpkg -S <fullpathfilename>
Which versions are available for a package
# apt-cache madison <package-name>
{% endraw %}
{% endhighlight %}

# Native package creation

So, packages are a good fit for deploying code into servers. How can we create packages? 

It's complicated, but ... meet [fpm](https://github.com/jordansissel/fpm) (a ruby gem). It helps you build packages quickly and easily (no kidding on this one!). 

Installing the tools is already simple, being a ruby gem is just a matter of executing:

{% highlight sh %}
gem install fpm
{% endhighlight %}


Building a package will only require declaring a source and an output like this:

{% highlight sh %}
fpm -s <source type> -t <target type> [list of sources]..
{% endhighlight %}


* "Source type" is what your package is coming from; a directory (dir), a rubygem (gem), an rpm (rpm), a python package (python), a php pear module (pear), etc.
* "Target type" is what your output package form should be. Most common are "rpm" and "deb" but others exist (solaris, etc)
* list of sources will depend on the source type.


# Naming Schema 

It helps a lot to use a naming schema when creating native packages. Any schema wil work as long as it's carefully thought of and enforce from the begining.

One proposal can be the following

{% highlight sh %}
{% raw %}
<company-name>-<component-name>-<semver>-<branch>-<sha>-<serial>_<arch>.deb 
{% endraw %}
{% endhighlight %}


* company name. It's easy just to type <code>dpkg -l 'company-name'-*</code> in order to check custom installed packages. It helps with the scripting.
* component name. Just the name of the package.
* semver. Semantic versioning, more on this in a bit.
* branch. Chances are you're using some sort of code versioning tool. It helps enforcing deployment policies. Supose you deploy code from master branch in staging and production environments and from dev branch in testing. This will help avoid installing packages in the wrong environment.
* sha. If using git, this is the commit id.
* serial. It allows the creation of more than one package with the same code (branch and sha). When using jenkins to build packages, can be the <code>BUILD_NUMBER</code> allowing easy access to the build which created that package.

Two words of advice:

* [Semver](http://semver.org/)
* Convention over configuration

Semver works not only for proper package versioning but for helping enforce dependencies later on.

It is almost certain that deployment scripts will parse package names at some point, enforce convention over configuration in order to avoid having to patch those scripts everytime a developer arrives with an odly named package. It will make you waste time but also important, will make him wait longer while we search for a 'workaround' instead of using the benefits of the already existing insfrastructure.

Last but not least. If the lenght of the package name cause any concerns, keep in mind it's not supposed to be handled by humans,  but by automation tools. Readability works so we're still good.

# Conclusion

A tool was created to deal with the above scenario. A collection of yam files where you define variables and get a native package in return. Ansible is used as the glue, fpm for package creation and aptly for publishing the packages. 
For input a plugable architecture allows for defining several sources, same for the output.

Technologies such as docker, will complement this approach. What if you don't need an rpm package for deploying code on a docker container? No problem, you had already a system in place capable of pulling the source from every component you have. That's half the battle already won. Adding a layer to store the code in a container and publish it would only be as hard as adding an ansible playbook.


