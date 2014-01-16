actions :install
default_action :install

attribute :module_name, :kind_of => String, :name_attribute => true
attribute :version,     :kind_of => [String, NilClass], :default => nil
attribute :pear_deps,   :kind_of => Array, :default => []
