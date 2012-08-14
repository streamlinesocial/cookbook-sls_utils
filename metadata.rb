maintainer        "Streamline Social"
maintainer_email  "support@streamlinesocial.com"
license           "Apache 2.0"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.0"

%w{ centos }.each do |os|
  supports os, ">= 6.0"
end

recommends "php", ">= 1.0.2"
recommends "apache2", ">= 1.1.12"
recommends "iptables"

recipe "sls_utils", "Empty recipe."
recipe "sls_utils::port_http", "Opens port 80 in the iptables."
recipe "sls_utils::port_ssh", "Opens port 22 in the iptables."
recipe "sls_utils::deploy_key", "Creates a private key for the apache user for site deployments."
recipe "sls_utils::default_site", "Override apache2 cookbook's default site."
