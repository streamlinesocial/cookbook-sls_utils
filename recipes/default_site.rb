apache_site "default" do
  enable false
end

web_app "vagrant" do
  server_name 'localhost'
  server_aliases []
  docroot "/srv"
  cookbook "sls_utils"
end
