require_recipe 'iptables'

# enable the http port
iptables_rule "port_http"
