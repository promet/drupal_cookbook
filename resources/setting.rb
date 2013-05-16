actions :create,  :delete
default_action  :create

attribute :name,      :name_attribute => true
attribute :site,      :kind_of => String
attribute :variables, :kind_of => Hash
