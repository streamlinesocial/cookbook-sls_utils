actions :create, :delete

default_action :create

attribute :owner,               :kind_of => String, :name_attribute => true
attribute :path,                :kind_of => String, :default => "/tmp/private_key"
attribute :file_name,           :kind_of => String, :default => "wrap-ssh4git.sh"
attribute :deploy_key_name,     :kind_of => String, :default => "id_deploy"
attribute :deploy_key_bag_item, :kind_of => String, :default => "default"
