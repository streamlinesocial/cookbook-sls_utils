# ensure the paths for the centos box are properlly setup for the /usr/sbin folder, some recipies will fail otherwise

# http://serverfault.com/questions/102932/adding-a-directory-to-path-in-centos
# echo 'pathmunge /usr/lib/ruby-enterprise/bin' > /etc/profile.d/ree.sh
# chmod +x /etc/profile.d/ree.sh
# 1. add usr/sbin file to the profile.d folder
# 2. ensure the file is executable
# 3. run the file to trigger an path update now
# script "add_usr_sbin_to_path" do
#   interpreter "bash"
#   user "root"
#   cwd "/tmp"
#   code <<-EOH
#   pathmunge '/usr/sbin' > /etc/profile.d/usr_sbin_path.sh
#   chmod +x /etc/profile.d/usr_sbin_path.sh
#   /etc/profile
#   EOH
# end
#
#
# execute "/etc/profile" do
#   action :run
# end

script "add_usr_local_to_path" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
    echo 'export PATH=$PATH:/usr/local/bin' > /etc/profile.d/usrlocal.sh
    EOH
    not_if { ::File.exist?('/etc/profile.d/usrlocal.sh') }
end

script "add_usr_sbin_to_path" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  chmod +x /etc/profile
  /etc/profile
  EOH
  not_if "ls -la /etc/profile | grep 'rwxr-xr-x'"
end
