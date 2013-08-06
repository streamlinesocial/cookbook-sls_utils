case node["sls_utils"]["git_install_method"]
when "source"
    include_recipe "git::source"
else
    include_recipe "git"
end
