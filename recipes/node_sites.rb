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

projects = node['drupal']['projects'].to_hash

projects.each do |p_name, project|

  project_root = "/var/drupals/#{p_name}"
  doc_root = "#{project_root}/www"

  drupal_project doc_root

  sites = project['sites']

  sites.each do |site_name, site|
    drupal_site site_name do
      drupal_root   doc_root
      site_uri      site['uri']
      site_subdir   site['subdir'] ? site['subdir'] : site['uri']
    end
    if site['build']
      execute site['build'] do
        cwd project_root
      end
    end
  end
end
