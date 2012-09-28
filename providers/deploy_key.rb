# create a deploy wrapper key with the given user as the owner
action :create do

    # ensure dir is created, e.g. /tmp/private_key
    directory new_resource.path do
        recursive true
    end

    # create wrapper script, e.g. /tmp/private_key/wrap-ssh4git.sh
    template "#{new_resource.path}/#{new_resource.file_name}" do
        action :create
        cookbook "sls_utils"
        owner new_resource.owner
        source "wrap-ssh4git.sh"
        mode 0700
        variables(
            :deploy_key_path => "#{new_resource.path}/#{new_resource.deploy_key_name}"
        )
    end

    # require a default deploy key data_bag
    deploy_key = data_bag_item('deploy_keys', new_resource.deploy_key_bag_item)

    # create deploy private key file, e.g. /tmp/private_key/id_deploy
    file "#{new_resource.path}/#{new_resource.deploy_key_name}" do
        content deploy_key['private_key']
        owner new_resource.owner
        mode 0600
    end
end

# delete a deploy key wrapper with the given user as the owner
action :delete do
    file "#{new_resource.path}/#{new_resource.file_name}" do
        action :delete
        owner new_resource.owner
    end

    file "#{new_resource.path}/#{new_resource.deploy_key_name}" do
        action :delete
        owner new_resource.owner
    end
end
