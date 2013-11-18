actions :create,  :delete
default_action  :create

attribute :uri,             :kind_of => String, :name_attribute => true
attribute :owner,           :kind_of => [String, NilClass], :default => nil
attribute :group,           :kind_of => [String, NilClass], :default => nil
attribute :root,            :kind_of => String, :default => '/var/www/drupal'
attribute :doc_root,        :kind_of => [String, NilClass], :default => nil
attribute :subdir,          :kind_of => String, :default => 'default'
attribute :settings_source, :kind_of => [String, NilClass], :default => nil
attribute :settings_dir,    :kind_of => [String, NilClass], :default => nil
attribute :config,          :kind_of => Hash, :default => {}
