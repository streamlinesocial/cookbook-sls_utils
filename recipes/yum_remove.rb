node['sls_utils']['yum_remove'].each do |pkg|
    Chef::Log.info "Removing package: #{pkg}"

    p = package "remove-#{pkg}" do
        package_name pkg
        action :nothing
        # this is here to prevent cases specific to this exameple, where a package was removed because
        # it emulated another package
        #
        # "yum remove mysql-libs" would remove mysql55-libs
        # we don't want that we want exact matching
        #
        # this is a behavior of yum, not chef
        only_if "yum list installed | grep '^#{pkg}\.'"
    end

    p.run_action(:remove)
end
