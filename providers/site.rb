action :create do
  # TODO: generalize to work with nginx or default to root
  group = new_resource.group || node.apache.group
  owner = new_resource.owner || node.apache.user
  settings_path = new_resource.settings_dir || "/etc/drupals/#{new_resource.uri}"
  if new_resource.doc_root
    doc_root = ::File.join(new_resource.root, new_resource.doc_root)
  else
    doc_root = new_resource.root
  end
  site_path = "#{doc_root}/sites/#{new_resource.subdir}"

  directory settings_path do
    owner     owner
    group     group
    mode      0750
    recursive true
  end

  directory site_path do
    owner     owner
    group     group
    mode      0775
    recursive true
  end

  cookbook_file 'settings.php' do
    action  :create_if_missing
    owner   owner
    group   group
    mode    0660
    path    ::File.join(site_path, 'settings.php')
    source  'settings.php'
  end

  file ::File.join(site_path, 'env.json') {
    owner   owner
    group   group
    content ::JSON.pretty_generate(
      conf_dir: settings_path
    )
    mode    0660
  }

  settings_compile settings_path

  uri = new_resource.uri
  web_app uri do
    server_name     uri
    docroot         doc_root
    server_aliases  []
    cookbook        'apache2'
    allow_override  ['All']
  end
  hostsfile_entry '127.0.1.1' do
    hostname  uri
    action    :append
  end
  new_resource.updated_by_last_action(true)
end

def settings_compile(settings_path)
  ini_conf_d      = "#{settings_path}/ini.conf.d"
  globals_conf_d  = "#{settings_path}/globals.conf.d"
  config = new_resource.config
  [ini_conf_d, globals_conf_d].each do |dir|
    directory dir do
      owner     owner
      group     group
      recursive true
    end
  end
  file ::File.join(globals_conf_d, 'globals.default.json') do
    owner   owner
    group   group
    content ::JSON.pretty_generate(config)
    mode    0660
  end
end
