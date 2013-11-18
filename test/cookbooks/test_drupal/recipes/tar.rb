#
# Cookbook Name:: test_drupal
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

# Test provisioning a drupal site from a tarball

ark 'drupal' do
  path ::File.join(node.drupal.sites_dir, 'foo.dev')
  url "http://ftp.drupal.org/files/projects/drupal-7.23.tar.gz"
  action :put
  strip_leading_dir true
end
