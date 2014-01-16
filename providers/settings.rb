action :create do
  settings_compile(new_resource.path)
end

def settings_compile(settings_path)
  ini_conf_d      = "#{settings_path}/ini.conf.d"
  globals_conf_d  = "#{settings_path}/globals.conf.d"
  [ini_conf_d, globals_conf_d].each do |dir|
    directory dir do
      owner     new_resource.owner
      group     new_resource.group
      recursive true
    end
  end
  file ::File.join(globals_conf_d, 'globals.default.json') do
    owner   new_resource.owner
    group   new_resource.group
    content ::JSON.pretty_generate(new_resource.config)
    mode    0660
  end
end
