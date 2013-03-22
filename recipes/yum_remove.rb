Chef::Log.info node['sls_utils']['yum_remove']

node['sls_utils']['yum_remove'].each do |pkg|

    Chef::Log.info pkg

    package "remove-#{pkg}" do
        package_name pkg
        action :remove
    end
end
