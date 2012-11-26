actions :development, :production
# actions :sync, :checkout, :export, :force_deploy

default_action :development

# Covers 0.10.8 and earlier default_action
def initialize(*args)
  super
  @action = :development
end

attribute :path,                :kind_of => String, :name_attribute => true
attribute :owner,               :kind_of => String, :default => "apache"
attribute :group,               :kind_of => String, :default => "apache"
attribute :set_owner_group,     :kind_of => Boolean, :default => false

attribute :repository, :kind_of => String
attribute :revision, :kind_of => String
attribute :shallow_clone, :kind_of => Boolean, :default => true
attribute :ssh_wrapper, :kind_of => String, :default => "/tmp/private_key/wrap-ssh4git.sh"
attribute :script_before_migrate, :kind_of => String, :default => "script/before_migrate.sh"
attribute :script_migrate, :kind_of => String, :default => "script/migrate.sh"
attribute :script_before_restart, :kind_of => String, :default => "script/before_restart.sh"



deploy_path = "/var/www/vhosts/#{node['drupal']['server_name']}"
shared_path = "#{deploy_path}/shared"
# release_path = "/var/www/vhosts/#{node['drupal']['server_name']}/current"

deployUser = node['drupal']['deploy_user']
deployGroup = node['drupal']['deploy_group']
deployRepo = node["drupal"]["deploy"]["repository"]
deployBranch = node["drupal"]["deploy"]["revision"]

environmentVars = ({ 'MYSQL_DB'   => node["drupal"]["mysql_name"],
                     'MYSQL_USER' => node["drupal"]["mysql_user"],
                     'MYSQL_PASS' => node["drupal"]["mysql_pass"],
                     'MYSQL_HOST' => node["drupal"]["mysql_host"] })

