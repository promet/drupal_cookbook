define :drush, :drush_bin => '/usr/local/bin' do

  drush_root      = node['drupal']['drush']['root']
  drush_version   = params[:version] ? params[:version] : nil
  drush_version   ||= params[:name]
  drush_path      = "#{drush_root}/#{drush_version}"
  drush_cache     = "#{drush_root}/cache"
  drush_bin       = params[:drush_bin]
  drush_uri       = "http://ftp.drupal.org/files/projects"
  drush_tar       = "#{drush_cache}/drush-#{drush_version}.tar.gz"
  drush_checksum  = params[:checksum]

  [drush_cache, drush_path].each do |dir|
    directory dir do
      owner     "root"
      group     "root"
      mode      "0755"
      action    :create
      recursive true
    end
  end

  remote_file drush_tar do
    checksum  drush_checksum
    source    "#{drush_uri}/drush-#{drush_version}.tar.gz"
    mode      "0644"
  end

  execute "untar-drush" do
    cwd     drush_root
    command "tar --strip-components 1 -xzf #{drush_tar} -C #{drush_path}"
    not_if  "/usr/local/bin/drush --version --pipe | grep #{drush_version}"
  end

  link "#{drush_bin}/drush" do
    to "#{drush_path}/drush"
  end

  execute "#{drush_bin}/drush"

end
