[![Build
Status](https://travis-ci.org/promet/drupal-cookbook.png?branch=master)](https://travis-ci.org/promet/drupal-cookbook)

# drupal cookbook

Provides a simple lwrp for drupal sites and some example recipes.

# Requirements

php
apache2

# Usage
This example from the foo recipe will configure a doc root on the guest and set
up a database and a vhost. It won't actually put Drupal in there, it won't
actually create or configure databases or redis or memcached or solr. Example
cookbooks for this will come along as part of integration testing efforts.

```
drupal_site 'foo.net' do
root    '/var/drupals/foo'
config({
  'database' => {
    'default' => {
      'default' => {
        database => 'fooDB',
        username => 'fooDBA',
        password => 'fooPASS',
      }
    }
  }
})
end
```

The following example installs drush of the given version
```
drush '8.x-6.x-dev'
```

# Attributes

node['drupal']['drush']['version'] -- the version of drush to install
(drupal.org version string)

node['drupal']['sites_dir'] -- the base path for sites installed with the dbag
recipe

node['drupal']['data_bag'] -- the data bag whose items represent drupal config
for the dbag recipe

node['drupal']['data_bag_items'] -- the items of the data bag whose items represent
drupal config for the dbag recipe

node['drupal']['shared_dir'] -- the path to which to download shared drupal
libraries distributed as modules for things like cache backends

# Recipes

default: provisions the node with a working LAMP stack for Drupal

node\_sites: a simple way to invoke the LWRP from your Vagrantfile -- pretty
janky, not especially happy with it, but I feel that multi-tenant drupals is
a pretty important goal and forcing people to knife some data_bags and roles
and is exactly what I don't want to do.

data\_bags: allows you to ship configuration in data bags (see attributes)

# Author

Author:: Will Milton (<will@prometsource.com>)
