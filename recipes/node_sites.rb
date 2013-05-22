#
# Cookbook Name:: drupal
# Recipe:: node_sites
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

include_recipe 'drupal::default'

node['drupal']['sites'].to_hash.each do |uri, info|
  site = drupal_site uri do
    db_init true
  end
  info.each do |parameter, value|
    site.send(parameter, value)
  end
end
