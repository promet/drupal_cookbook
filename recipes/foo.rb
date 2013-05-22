# git '/var/drupals/foo' do
#   repository  'http://git.drupal.org/project/drupal.git'
#   reference   '8.x'
#   action      :sync
#   user        'vagrant'
#   group       'www-data'
# end

drupal_site 'foo.net' do
  root        '/var/drupals/foo'
  db          'fooDB'
  db_username 'fooDBA'
  db_password 'fooPASS'
  db_init     true
end
