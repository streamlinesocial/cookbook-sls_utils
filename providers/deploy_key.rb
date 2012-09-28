# create a deploy wrapper key with the given user as the owner
action :create do
    directory new_resource.path do
        recursive true
    end

    cookbook_file "#{new_resource.path}/#{new_resource.file_name}" do
        action :create
        owner new_resource.owner
        source "wrap-ssh4git.sh"
        mode 0700
    end
end

# delete a deploy key wrapper with the given user as the owner
action :delete do
    # directory new_resource.path do
    #     action :delete
    #     recursive true
    # end

    cookbook_file "#{new_resource.path}/#{new_resource.file_name}" do
        action :delete
        owner new_resource.owner
        source "wrap-ssh4git.sh"
    end
end
