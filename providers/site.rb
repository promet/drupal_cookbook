use_inline_resources

action :create do
  settings_path = new_resource.settings_dir || "/etc/drupals/#{new_resource.uri}"
  site_settings_path = ::File.join(settings_path, new_resource.uri)
  if new_resource.doc_root
    doc_root = ::File.join(new_resource.root, new_resource.doc_root)
  else
    doc_root = new_resource.root
  end
  [settings_path, site_settings_path, doc_root].each do |path|
    directory path do
      owner     new_resource.user
      group     new_resource.group
      mode      0750
      recursive true
    end
  end

  file ::File.join(new_resource.root, 'env.json') do
    owner   new_resource.user
    group   new_resource.group
    content ::JSON.pretty_generate(conf_dir: settings_path)
    mode    0660
  end
  drupal_settings site_settings_path do
    owner   new_resource.user
    group   new_resource.group
    config  new_resource.config
  end
  uri = new_resource.uri
  # web_app uri do
  #   server_name     uri
  #   docroot         doc_root
  #   server_aliases  []
  #   cookbook        'apache2'
  #   allow_override  ['All']
  # end
  hostsfile_entry '127.0.1.1' do
    hostname  new_resource.uri
    action    :append
  end
  new_resource.updated_by_last_action(true)
end
