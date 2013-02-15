include_recipe 'memcached'

php_pear 'memcache' do
  action :install
end
