actions :run
default_action :run

attribute :command,         :kind_of => String, :name_attribute => true
attribute :args,            :kind_of => [Array, String], :default => []
attribute :user,            :kind_of => [String, NilClass], :default => nil
attribute :flags,           :kind_of => Array, :default => ['y']
attribute :options,         :kind_of => Hash, :default => {}
attribute :alias,           :kind_of => [String, NilClass], :default => nil
attribute :executable,      :kind_of => [String, NilClass], :default => nil
