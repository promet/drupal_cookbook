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
use_inline_resources

action :install do
  directory node.drupal.shared_dir do
    recursive true
    not_if ::File.exists?(node.drupal.shared_dir)
  end

  new_resource.pear_deps.each do |dep|
    php_pear dep
  end

  drupal_drush "dl #{new_resource.module_name} module" do
    command 'dl'
    args [new_resource.module_name]
    options destination: node.drupal.shared_dir
  end
  new_resource.updated_by_last_action(true)
end
