### 0.0.1

- Added usrlocal.sh to /etc/profile.d to add /usr/local/bin to the executable global path
- Added recipe for chef server port sls_utils::port_chef_server
- Added yum_repo recipe to replace manual management of yum repo, mainly to get the repo installed via rpm and thus trigger the epel-testing repo install. (the whole yum repo management by hand is tedious.)
