actions :create,  :delete
default_action  :create

attribute :path,    :name_attribute => true
attribute :config,  :kind_of => Hash
attribute :owner,   :kind_of => [String, NilClass], :default => nil
attribute :group,   :kind_of => [String, NilClass], :default => nil
