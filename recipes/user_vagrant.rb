
# ensure vagrant user is setup right
user "vagrant" do
	action :manage
	gid 'vagrant'
end

# ensure the vagrant users is in the apache group
execute "usermod -a -G apache vagrant"
