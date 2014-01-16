#
# Anything in the Drupal Sites Directory gets served like a Drupal Site
#
include_recipe "drupal"
include_recipe "apache2"

apache_module "vhost_alias"
web_app "mass_virtual" do
  docroot         node['drupal']['sites_dir']
  rel             'www'
  allow_override  'None'
  cookbook        'drupal'
  template        'mass_virtual.conf.erb'
end
