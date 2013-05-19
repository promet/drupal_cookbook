action :create do
  site_path = "#{new_resource.root.path}/sites/#{new_resource.subdir}"
  directory site_path do
    recursive true
    owner     new_resource.root.owner
    group     new_resource.root.group
  end

  template "#{site_path}/settings.php" do
    owner     new_resource.root.owner
    group     new_resource.root.group
    if new_resource.settings_source.nil?
      source "settings.php.erb"
      cookbook 'drupal'
    else
      source new_resource.settings
    end
  end
  site_conf_d     = "#{site_path}/settings.conf.d"
  ini_conf_d      = "#{site_conf_d}/ini.conf.d"
  globals_conf_d  = "#{site_conf_d}/globals.conf.d"
  [site_conf_d, ini_conf_d, globals_conf_d].each do |dir|
    directory dir do
      owner     new_resource.root.owner
      group     new_resource.root.group
      recursive true
    end
  end

  template "#{globals.conf.d}/databases.json" do
    owner   new_resource.root.owner
    group   new_resource.root.group
    source  "databases.my.default.json.erb"
    variables ({
      username: new_resource.db_username,
      password: new_resource.db_password,
      database: new_resource.db,
    })
  end

end
