#!/bin/bash
yum update -y aws-cfn-bootstrap
yum update -y
yum install git -y
/usr/bin/curl -L https://www.opscode.com/chef/install.sh | bash
/bin/mkdir -p /root/chef-repo/.chef
cd /root/chef-repo/.chef
echo "10.0.0.254  chefserver.lab.com" >> /etc/hosts
echo "10.0.0.141  resourceserver.lab.com" >> /etc/hosts
echo "10.0.0.228  jenkinsserver.lab.com" >> /etc/hosts
curl -o knife.rb http://10.0.0.141/knife
curl -o siva.pem http://10.0.0.141/siva
knife ssl fetch
cd /root/chef-repo
/bin/mkdir -p /etc/chef
cd /etc/chef
curl -o validator.pem http://10.0.0.141/validator
curl -o client.rb http://10.0.0.141/client.rb
cp -far /root/chef-repo/.chef/trusted_certs /etc/chef/
/usr/sbin/ntpdate -q 0.europe.pool.ntp.org
/usr/bin/chef-client
