#
# Cookbook Name:: drupal
# Recipe:: default
#
# Copyright (C) 2013 Will Milton
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'apt'
apt_repository 'dotdeb' do
  uri "http://packages.dotdeb.org"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
  deb_src true
  distribution node['lsb']['codename']
end

apt_repository 'dotdeb-php54' do
  uri "http://packages.dotdeb.org"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
  deb_src true
  distribution "#{node['lsb']['codename']}-php54"
end

include_recipe 'postfix'
include_recipe 'php'
include_recipe 'php::module_mysql'
include_recipe 'php::module_gd'
# include_recipe 'php::module_apc'
include_recipe 'php::module_curl'
package 'php5-apc'

include_recipe 'git'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'database::mysql'
include_recipe 'mysql::server'
