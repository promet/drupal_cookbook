define :drupal_site, :enable => true, :httpd_group => 'www-data' do

  site_name   = params[:name]
  site_uri    = params[:site_uri]
  drupal_root = params[:drupal_root]
  site_path   = "#{drupal_root}/sites/#{site_uri}"
  drupal_user = params[:drupal_user]  ? params[:drupal_user]    : node['apache']['user']
  components  = params[:components]   ? params[:components]     : []
  httpd_group = params[:httpd_group]  ? params[:httpd_group]    : node['apache']['group']

  directory "#{site_path}" do
    owner drupal_user
    group node['apache']['group']
    not_if "stat #{site_path}"
  end

  directory "#{site_path}/files" do
    owner drupal_user
    group node['apache']['group']
    not_if "stat #{site_path}/files"
  end

  db_name     = "#{site_name}DB"
  db_user     = "#{site_name}DBA"
  db_password = "#{site_name}PASS"

  template "#{site_path}/settings.php" do
    source    'settings.php.erb'
    owner     drupal_user
    group     node['apache']['group']
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    not_if do 
      File.exists? "#{site_path}/settings.php"
    end

    variables(
      :username   => db_user,
      :password   => db_password,
      :database   => db_name,
      :components => components
    )
  end

  # execute "#{Chef::Config[:file_cache_path]}/file-permissions.sh --httpd_group=#{httpd_group} --drupal_path=#{drupal_root} --drupal_user=#{drupal_user}"

  web_app site_name do
    server_name     site_uri
    server_aliases  [site_uri]
    docroot         "#{drupal_root}"
    allow_override  'All'
    cookbook        'apache2'
  end

  mysql_connection = {
    :host => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
  }

  mysql_database db_name do
    connection mysql_connection
    action :create
  end

  mysql_database_user 'drupal_db_user_create' do
    username db_user
    connection mysql_connection
    password db_password
    database_name db_name
    action :create
  end

  mysql_database_user 'drupal_db_user_grant' do
    username db_user
    connection mysql_connection
    password db_password
    database_name db_name
    action :grant
  end

end
