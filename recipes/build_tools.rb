# Stop-gap effort to include necessary tools for running build scripts.

chef_gem 'rake'

# The best debian apt ruby is 'good enough' for now....
# TODO: figure out the costs of an rbenv solution (besides the obvious).
package 'ruby1.9.1-full'

#TODO: find an easy way to install gems from source
remote_file "/tmp/rubygems.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-2.0.3.tgz"
  not_if "which gem"
end

execute "tar xzf /tmp/rubygems.tgz" do
  cwd "/root"
  not_if "which gem"
end

execute "ruby setup.rb --no-format-executable" do
  cwd "/root/rubygems-2.0.3"
  not_if "which gem"
end

gem_package "rake"
