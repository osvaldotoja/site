---
layout: page
title: Services
---
# Server Administration

We specialise in Linux server and network administration, and can:

* Provision Linux servers for you from whatever provider you prefer. Drupblue recommends and uses Linode and the Rackspace Cloud.
* Provide and perform regular security upgrades as they are released, to keep your system up to date and secure.
* Install and configure applications or services on your server
* Make optimisations to your server if required
* Troubleshoot problems and respond to incidents/outages and get things working for you again.
* Set up Nagios monitoring and Munin graphs to cover very low-level diagnostics of your system.


## Mail servers

There're many options available today. Some of the scenarios installed and maintained by Drupblue include the following.

* Incoming mail servers farm running qmail using an nfs mounted filesystem for mailboxes storage. Frontend provided by a high performance three tier OpenXchange servers.
* Sendmail with mailscanner, mailwatch and greylisting support.
* postfix with ldap virtual account support, antivirus/antispam support and courier-imap (custom built rpm) for pop3/imap services.
* webmail and web based admin tools.

## Nagios and Munin

Whether you run your own server or we provision and manage it for you, Drupblue can help you monitor your system and the services running on it using using the industry standard sysadmin monitoring tool [Nagios](http://www.nagios.org/). This tool constantly performs checks to retrieve low-level statistics about your system.

Depending on whether the result of the check is OK or CRITICAL, Nagios can even send you alerts that there's a problem. Alerts can come in the form of Push notifications to your iPhone, SMS, and / or e-mail, and often several of these at once.

Prefer a graphical representation of your system? Drupblue recommends using the popular tool [Munin](http://munin-monitoring.org/) to poll your server and generate graphs of your system regularly, which can be useful to identify slowly growing issues, or even troubleshoot a situation that occurred 5 minutes ago but has recovered.

## Secure Offsite backups

Drupblue can build tools for you that use the excellent program Duplicity to take backups of your server, encrypt them to prevent unauthorised reading, and store them in the Amazon S3 cloud.

Because the backups are encrypted, they are safe in the cloud. [Duplicity](http://duplicity.nongnu.org/) runs full and incremental backups, allowing you to restore your server back to any point in time!

Duplicity is the perfect backup system for the Cloud, because the costs are low, there is no need to purchase additional hardware, and your backups are stored offsite from the server you're backing up in the first place.

Your backup crons will send you a report every time they are run, stating whether the backup was a success and what changed.

## Offsite backup tests

In conjunction with our Offsite Backup service, Drupblue offers state-of-the-art tools that will automatically create new servers in the Cloud on demand, restore your backups to them and send you a report. You'll have SSH access to the new server for 48 hours to sift through your backups or restore if needed. This entire process is automated thanks to Cloud-based technology!

## Firewalls and security hardening

You should always have a firewall running on your server to prevent unauthorised access or exploitation by malicious parties. Drupblue can write custom iptables firewall rules tailored to your needs. You'll get a copy of the script plus documentation outlining what it does, in our excellent Support system.

In some cases it may not be possible for you to lock down SSH access to specific source IP addresses. Drupblue can still help you by

* locking down SSH to use public SSH key authentication only (no clear text passwords),
* run '3-strike' IP blocking systems such as DenyHosts or Fail2Ban,
* configuring SSH to run on non-standard ports,
* preventing root user logins, and
* allowing SSH access to only specific system users.

## OTRS

OTRS, an initialism for Open-source Ticket Request System, is a free and open-source trouble ticket system software package that a company, organization, or other entity can use to assign tickets to incoming queries and track further communications about them. It is a means of managing incoming inquiries, complaints, support requests, defect reports, and other communications.

Drupblue offers consulting services to any and all users of the OTRS system wherever you may need. 

Specialising in:

* Installing OTRS - Drupblue can provision Linux servers for you from recommended VPS providers or install on your existing server
* Upgrading OTRS - Drupblue understands and even wrote some of the mechanics of OTRS, so he know how to safely upgrade!
* Troubleshooting OTRS - sometimes things go wrong. Drupblue can investigate and diagnose or fix the issue for you
* Selling OTRS - we can demonstrate and explain the benefits of OTRS to help convince your clients it's a good idea
* Training and best practices - workshops to be announced soon, or contact us for private sessions for you and your agency

All OTRS consultancy work is charged based on an estimate of hours required to complete the work.


# Devops

We can help you setup your development workflow. 
Setting up the different environments (dev/qac/qat/prod) along with the required tools, like continuous integration systems, source code versioning systems, monitoring, logging and deployment. More info can be found in the [devops blog](http://www.devop.com.ar)

Get in touch!