# custom default site template to serve default site from /srv folder
template "#{node['apache']['dir']}/sites-available/default" do
  source "default_site.erb"
  owner "root"
  group node['apache']['root_group']
  mode 0644
  notifies :restart, resources(:service => "apache2")
end

# ensure we enabled the defaut
apache_site "default" do
  enable true
end

# enable on boot, and ensure server is started
%w{ apache2 }.each do |service_name|
  service "#{service_name}" do
    action [ :enable, :start ]
  end
end
