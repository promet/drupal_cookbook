droot = directory '/var/drupals/foo' do
  owner 'vagrant'
  group 'www-data'
end

dsite = drupal_site 'foo.net' do
  root droot
end
