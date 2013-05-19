droot = directory '/var/drupals/foo' do
  owner     'vagrant'
  group     'www-data'
  recursive true
end

dsite = drupal_site 'foo.net' do
  root  droot
  db          'foo.net'
  db_username 'fooDBA'
  db_password 'fooPASS'
end
