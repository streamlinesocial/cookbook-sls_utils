maintainer        "Streamline Social"
maintainer_email  "support@streamlinesocial.com"
license           "Apache 2.0"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.5.0"

%w{ centos }.each do |os|
  supports os, ">= 6.0"
end

recommends "postfix", ">= 2.1.6"
recommends "php", ">= 1.0.2"
recommends "apache2", ">= 1.1.12"
recommends "iptables", ">= 0.12.0"

recipe "sls_utils", "Empty recipe."
recipe "sls_utils::port_http", "Opens port 80 in the iptables."
recipe "sls_utils::port_ssh", "Opens port 22 in the iptables."
recipe "sls_utils::deploy_key", "Creates a private key for the apache user for site deployments."
recipe "sls_utils::default_site", "Override apache2 cookbook's default site."
recipe "sls_utils::centos_profile", "Ensure the /usr/sbin (and maybe other folers) are in the PATH var."
recipe "sls_utils::port_mysql_local", "Open port 3306 in the iptables for accessing from localhost."
