# allow ssh connections explicityly so to never get locked out
iptables_rule "port_mysql_local" do
    variables({
        "port" => node['rundeck']['port']
    })
end
