node['sls_utils']['yum_remove'].each do |pkg|
    Chef::Log.info "Removing package: #{pkg}"

    p = package "remove-#{pkg}" do
        package_name pkg
        action :nothing
    end

    p.run_action(:remove)
end
