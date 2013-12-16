#
# Anything in the Drupal Sites Directory gets served like a Drupal Site
#
include_recipe "drupal"
include_recipe "apache2"

apache_module "vhost_alias"
web_app "mass_virtual" do
  docroot node['drupal']['sites_dir']
  allow_override 'All'
  cookbook 'drupal'
  template 'mass_virtual.conf.erb'
end
