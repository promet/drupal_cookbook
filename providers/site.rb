action :create do
  site_path = "#{new_resource.root.path}/sites/#{new_resource.subdir}"
  directory site_path do
    recursive true
    owner     new_resource.root.owner
    group     new_resource.root.group
  end

  default_template = template "#{site_path}/settings.php" do
    source "settings.php.erb"
    cookbook 'drupal'
  end

  settings_template = new_resource.settings ? new_resource.settings : default_template

end
