def install_php_pear(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:php_pear, :install, resource_name)
end
