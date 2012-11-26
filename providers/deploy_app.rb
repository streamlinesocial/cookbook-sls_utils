# create a deploy wrapper key with the given user as the owner
action :development do

    # ensure directory exists
    directory new_resource.path do
        recursive true
    end

    # scm clone
    git release_path do
        action :checkout
        repository deployRepo
        revision deployBranch
        user deployUser
        group deployGroup
        depth 5
        ssh_wrapper "/tmp/private_key/wrap-ssh4git.sh"
    end

    # run before_migrate
    execute "script/before_migrate.sh" do
        cwd release_path
        user deployUser
        group deployGroup
        environment environmentVars
    end

    # run migrate
    execute "script/migration.sh" do
        environment environmentVars
        cwd release_path
        user deployUser
        group deployGroup
    end

    # run before_restart
    execute "script/before_restart.sh" do
        environment environmentVars
        cwd release_path
        user deployUser
        group deployGroup
    end
end

action :production do
    # either deploy_revision or deploy (timestamp)
    deploy_revision deploy_path do

        action :deploy # or :rollback or force_deploy

        repository deployRepo
        revision deployBranch
        shallow_clone true
        ssh_wrapper "/tmp/private_key/wrap-ssh4git.sh"

        user deployUser
        group deployGroup

        # setup vendors and ensure install
        # runs before symlink_before_migrate
        before_migrate do
            execute "script/before_migrate.sh" do
                cwd release_path
                environment environmentVars
                user deployUser
                group deployGroup
            end
        end

        # setup configs for before migrate
        symlink_before_migrate({
            "config/drupal/files" => "public/sites/default/files",
            "config/drupal/settings.php" => "public/sites/default/settings.php"
        })


        # runs after symlinks are created
        migrate true
        environment environmentVars
        migration_command "script/migration.sh"

        # runs after before_migrate
        purge_before_symlink %w{}
        create_dirs_before_symlink %w{}
        symlinks({})

        # runs after migration
        before_restart do
            execute "script/before_restart.sh" do
                cwd release_path
                environment environmentVars
                user deployUser
                group deployGroup
            end
        end
    end
end
