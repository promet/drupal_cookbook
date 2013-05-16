actions :create,  :delete
default_action  :create

attribute :uri,           :kind_of => String, :name_attribute => true
attribute :root,          :kind_of => ::Chef::Resource
attribute :subdir,        :kind_of => String, :default => 'default'
attribute :conf_d,        :kind_of => [String, ::Chef::Resource, NilClass], :default => nil
attribute :settings,      :kind_of => [::Chef::Resource, NilClass], :default => nil
attribute :databases,     :kind_of => Hash, :default => {}
attribute :ini_settings,  :kind_of => Hash, :default => {}
attribute :conf_settings, :kind_of => Hash, :default => {}
