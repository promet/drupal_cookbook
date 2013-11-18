#
# Cookbook Name:: drupal
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'drupal'

directory node.drupal.sites_dir do
  recursive true
  owner node.drupal.user
  group node.apache.group
end

node.drupal.data_bag_items.each do |item|
  drupal_config = data_bag_item(node.drupal.data_bag, item).to_hash

  drupal_site drupal_config['uri'] do
    root        ::File.join(node.drupal.sites_dir, drupal_config['uri'])
    doc_root    drupal_config['doc_root']
    owner       node.drupal.user
    config      drupal_config
  end
end

