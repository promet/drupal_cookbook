actions :create,  :delete
default_action  :create

attribute :uri,             :kind_of => String, :name_attribute => true
attribute :root,            :kind_of => ::Chef::Resource
attribute :subdir,          :kind_of => String, :default => 'default'
attribute :settings_source, :kind_of => [String, NilClass], :default => nil
attribute :db_username,     :kind_of => String, :required => true
attribute :db_password,     :kind_of => String, :required => true
attribute :db,              :kind_of => String, :required => true
