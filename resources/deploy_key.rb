actions :create, :delete

default_action :create

# Covers 0.10.8 and earlier default_action
def initialize(*args)
  super
  @action = :create
end

attribute :owner,     :kind_of => String, :name_attribute => true
attribute :path,      :kind_of => String, :default => "/tmp/private_key"
attribute :file_name, :kind_of => String, :default => "wrap-ssh4git.sh"
