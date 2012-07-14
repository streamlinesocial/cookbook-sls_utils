require_recipe 'iptables'

# allow ssh connections explicityly so to never get locked out
iptables_rule "port_ssh"
