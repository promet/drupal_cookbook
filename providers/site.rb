action :create do

  group = new_resource.group.nil? ? node['apache']['group'] : new_resource.group
  owner = new_resource.owner.nil? ? node['apache']['user'] : new_resource.owner
  uri       = new_resource.uri
  doc_root  = new_resource.doc_root ? ::File.join(new_resource.root, new_resource.doc_root) : new_resource.root
  site_path = "#{doc_root}/sites/#{new_resource.subdir}"
  settings_path = new_resource.settings_dir.nil? ?  "/etc/drupals/#{uri}" : new_resource.settings_dir

  directory settings_path do
    owner     new_resource.owner
    group     group
    mode      0750
    recursive true
  end

  directory site_path do
    owner     new_resource.owner
    group     group
    mode      0775
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
    content ::JSON.pretty_generate({
      conf_dir: settings_path
    })
    mode    0660
  }

  settings_compile settings_path
  web_app new_resource.uri do
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

  if new_resource.db_init
    mysql_init new_resource.db_username, new_resource.db_password, new_resource.db
  end
end

def settings_compile(settings_path)
  ini_conf_d      = "#{settings_path}/ini.conf.d"
  globals_conf_d  = "#{settings_path}/globals.conf.d"
  config = new_resource.config
  [ini_conf_d, globals_conf_d].each do |dir|
    directory dir do
      owner     new_resource.owner
      group     new_resource.group
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
