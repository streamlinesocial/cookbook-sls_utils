directory "/tmp/.ssh" do
  recursive true
end

cookbook_file "/tmp/.ssh/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh"
  mode 0700
end

# deploy "private_repo" do
#   repo "git@github.com:acctname/private-repo.git"
#   user "apache"
#   deploy_to "/tmp/private_code"
#   action :deploy
#   ssh_wrapper "/tmp/private_code/wrap-ssh4git.sh"
# end
