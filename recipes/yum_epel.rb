directory "/root/rpms" do
    action :create
end

remote_file "epel-release-rpm" do
    path "/root/rpms/#{node['sls_utils']['yum_epel']['rpm_file']}"
    source "#{node['sls_utils']['yum_epel']['rpm_url']}"
    action :create_if_missing
    backup false
    notifies :install, "yum_package[epel-release]", :immediately
    not_if "test -f /etc/yum.repos.d/epel.repo"
end

yum_package "epel-release" do
    source "/root/rpms/#{node['sls_utils']['yum_epel']['rpm_file']}"
    action :nothing
end
