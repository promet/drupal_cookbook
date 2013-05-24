# For Drupalers Wanting a Local Environment

Unless you are interested in contributing to the ruby code contained herein
that would provision your virtual machine, Gandalf did not mean for you to come
this way.

If you run this from the root of your average drupal project, you will be able
to do the vagrant things (assuming you have vagrant and virtualbox installed).

```bash <(curl -s
https://gist.github.com/winmillwill/5629196/raw/3400ce207e05e0fa69d3a4dacaeb854d964f0ffa/drupal_vagary.sh)```

Also, patcon's ariadne project may be more your speed if you don't like this
one. See:

https://github.com/myplanetdigital/vagrant-ariadne

# drupal cookbook

Provides a simple lwrp for drupal sites and some example recipes.

# Requirements

php
apache2
mysql
database
apt

# Usage
This example from the foo recipe will configure a doc root on the guest and set
up a database and a vhost. It won't actually put Drupal in there. At this time,
the assumption is that you are using this for local development, and therefore
you will be putting your working copy in the doc root using nfs sharing in
vagrant, or perhaps managing that repository with another cookbook (or
submitting a pull request).

```
drupal_site 'foo.net' do
root        '/var/drupals/foo'
db          'fooDB'
db_username 'fooDBA'
db_password 'fooPASS'
db_init     true
end
```

The following example installs drush of the given version
```
drush '8.x-6.x-dev'
```

# Attributes

node['drush']['version'] -- the version of drush to install (drupal.org version
string)

# Recipes

default: provisions the node with a working LAMP stack for Drupal

foo: purely for testing and demonstration

node\_sites: a simple way to invoke the LWRP from your Vagrantfile -- pretty
janky, not especially happy with it, but I feel that multi-tenant drupals is
a pretty important goal and forcing people to knife some data_bags and roles
and is exactly what I don't want to do.

# Author

Author:: Will Milton (<will@promethost.com>)
