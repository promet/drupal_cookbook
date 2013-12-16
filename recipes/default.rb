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

include_recipe 'php'
include_recipe 'php::module_mysql'
include_recipe 'php::module_gd'
include_recipe 'php::module_curl'
include_recipe 'php::module_apc'

include_recipe 'drupal::drush'

%w(apps_dir settings_dir sites_dir).each do |dir|
  directory node['drupal'][dir] do
    owner node['drupal']['user']
    group node['drupal']['group']
    recursive true
  end
end
