service "exim" do
    action [ :stop, :disable ]
end

include_recipe "postfix"
