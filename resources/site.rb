actions :create,  :delete
default_action  :create

attribute :uri,             :kind_of => String, :name_attribute => true
attribute :owner,           :kind_of => [String, NilClass], :default => nil
attribute :group,           :kind_of => [String, NilClass], :default => nil
attribute :root,            :kind_of => String, :default => '/var/www/drupal'
attribute :doc_root,        :kind_of => [String, NilClass], :default => nil
attribute :subdir,          :kind_of => String, :default => 'default'
attribute :settings_source, :kind_of => [String, NilClass], :default => nil
attribute :db_username,     :kind_of => String, :default => 'devDBA'
attribute :db_password,     :kind_of => String, :default => 'devPASS'
attribute :db,              :kind_of => String, :default => 'devDB'
attribute :db_init,         :kind_of => [TrueClass, FalseClass], :default => false
