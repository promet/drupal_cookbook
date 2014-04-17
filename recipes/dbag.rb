#
# Cookbook Name:: drupal
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'drupal'
include_recipe 'apache2'

directory node.drupal.sites_dir do
  recursive true
  owner node.drupal.user
  group node.apache.group
end

node.drupal.data_bag_items.each do |item|
  drupal_config = data_bag_item(node.drupal.data_bag, item).to_hash

  drupal_site drupal_config['uri'] do
    root          ::File.join(node.drupal.sites_dir, drupal_config['uri'])
    doc_root      drupal_config['doc_root']
    user          drupal_config['user'] || node.drupal.user
    group         drupal_config['group'] || node.drupal.group
    settings_dir  drupal_config['settings_dir'] || node.drupal.settings_dir
    config        drupal_config
  end
end
