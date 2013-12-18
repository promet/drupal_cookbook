#
# Cookbook Name:: test_drupal
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Test provisioning a drupal site from a tarball
include_recipe 'test_drupal'
include_recipe 'postfix'

directory "#{node.drupal.sites_dir}/foobar.baz"
ark 'www' do
  path "#{node.drupal.sites_dir}/foobar.baz"
  url 'http://ftp.drupal.org/files/projects/drupal-7.23.tar.gz'
  action :put
end

execute "chown -R vagrant:www-data #{node.drupal.sites_dir}/foobar.baz"

cookbook_file "settings.php" do
  path "#{node.drupal.sites_dir}/foobar.baz/www/sites/default/settings.php"
  cookbook 'drupal'
  owner 'vagrant'
  group 'www-data'
end

drupal_config = data_bag_item('drupal', 'default').to_hash
drupal_settings "#{node.drupal.settings_dir}/default" do
  config drupal_config
  owner 'vagrant'
  group 'www-data'
end

file ::File.join(node.drupal.sites_dir, 'foobar.baz', 'www', 'sites', 'default', 'env.json') do
  owner   'vagrant'
  group   'www-data'
  content ::JSON.pretty_generate(
    conf_dir: "#{node.drupal.settings_dir}/default"
  )
  mode    0660
end

hostsfile_entry '127.0.0.1' do
  hostname 'foobar.baz'
  action :append
end
