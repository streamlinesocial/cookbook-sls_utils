maintainer        "Streamline Social"
maintainer_email  "support@streamlinesocial.com"
license           "Apache 2.0"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.0"

%w{ centos }.each do |os|
  supports os, ">= 6.0"
end

recipe "sls_utils", "Empty recipe."
recipe "sls_utils::apache2_default", "Enables apache with a custom default site to serve the /srv folder."
recipe "sls_utils::port_http", "Opens port 80 in the iptables."
recipe "sls_utils::port_ssh", "Opens port 22 in the iptables."
recipe "sls_utils::deploy_key", "Creates a private key for the apache user for site deployments."
