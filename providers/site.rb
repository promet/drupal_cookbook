action :create do

  group          = new_resource.group.nil? ? node['apache']['group'] : new_resource.group
  owner          = new_resource.owner.nil? ? node['apache']['user'] : new_resource.owner
  uri            = new_resource.uri
  doc_root       = new_resource.doc_root ? ::File.join(new_resource.root, new_resource.doc_root) : new_resource.root
  server_aliases = new_resource.server_aliases
  site_path      = "#{doc_root}/sites/#{new_resource.subdir}"
  settings_path  = new_resource.settings_dir.nil? ?  "/etc/drupals/#{uri}" : new_resource.settings_dir

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

  template "#{site_path}/settings.php" do
    action    :create_if_missing
    owner     new_resource.owner
    group     new_resource.group
    mode      0660
    if new_resource.settings_source.nil?
      source    "settings.php.erb"
      cookbook  'drupal'
    else
      source new_resource.settings_source
    end
      variables ({
        username:       new_resource.db_username,
        password:       new_resource.db_password,
        database:       new_resource.db,
        settings_path:  settings_path,
      })
  end

  settings_compile settings_path
  web_app new_resource.uri do
    server_name     uri
    docroot         doc_root
    server_aliases  server_aliases
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
  site_conf_d     = "#{settings_path}/settings.conf.d"
  ini_conf_d      = "#{site_conf_d}/ini.conf.d"
  globals_conf_d  = "#{site_conf_d}/globals.conf.d"

  [site_conf_d, ini_conf_d, globals_conf_d].each do |dir|
    directory dir do
      owner     new_resource.owner
      group     new_resource.group
      recursive true
    end
  end

  # TODO: break this out into its own LWRP
  template "#{globals_conf_d}/databases.json" do
    owner   new_resource.owner
    group   new_resource.group
    source  "databases.my.default.json.erb"
    cookbook  'drupal'
    mode    0660
    variables ({
      username: new_resource.db_username,
      password: new_resource.db_password,
      database: new_resource.db,
    })
  end

  template "#{globals_conf_d}/globals.default.json" do
    owner   new_resource.owner
    group   new_resource.group
    cookbook  'drupal'
    source  "globals.default.json.erb"
    mode    0660
    variables ({
      username: new_resource.db_username,
      password: new_resource.db_password,
      database: new_resource.db,
    })
  end

end

def mysql_init(user, pass, db)
  mysql_connection = {
    host:     'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  }

  mysql_database db do
    connection  mysql_connection
    action      :create
  end

  mysql_database_user user do
    connection    mysql_connection
    password      pass
    database_name db
    action        [:create, :grant]
  end
end
