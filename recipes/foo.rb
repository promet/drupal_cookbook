db = 'fooDB'
user = 'fooDBA'
pass = 'fooPASS'

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

drupal_site 'foo.net' do
  root        '/var/drupals/foo'
  doc_root    'www'
  owner       'vagrant'
  config({
    databases: {
      default: {
        default: {
          username: user,
          password: pass,
          database: db,
          host: 'localhost',
          driver: 'mysql',
        }
      }
    }
  })
end
