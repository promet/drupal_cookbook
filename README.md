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
node\_sites: a simple way to invoke the LWRP from your Vagrantfile
# Author

Author:: Will Milton (<will@promethost.com>)
