0.6.1
=====

- only run centos_profile changes if not already applied

0.6.0
=====

- add only_if yum/grep check in removal of packages to ensure that exact matchs are made rather than letting yum remove match similar packages that claim to meet the same dependencies

0.5.0
=====

- Added rundeck port access recipe (requires rundeck recipe)
- Added git install recipe to enable package / source install to be an attrib, wrapping the contriburted cookbook

0.4.1
=====

- Added mysql 3306 port access from localhost

0.4.0
=====

- add exim disable / setup postfix recipe


0.3.0
=====

- Added munin node port whitelist

0.2.1
=====

- updated the yum_remove recipe to run durring compile time so that use case of mysql/database cookbook with
  custom yum package can work with yum_install recipe

0.2.0
=====

- added yum_install recipe to manage adding yum repos at compile time (support mysql/database cookbook with custom mysql packages)
- update for chef 11.4.4, seems resources are throwing errors for the chef < 10.x fix for defaults

0.0.1
=====

- Added port_jenkins_jnlp recipe for opening the jenins port
- Added yum_remove recipe to clear the way for installs that are attribute defined (e.g. mysql client/server)
- Added usrlocal.sh to /etc/profile.d to add /usr/local/bin to the executable global path
- Added recipe for chef server port sls_utils::port_chef_server
- Added yum_repo recipe to replace manual management of yum repo, mainly to get the repo installed via rpm and thus trigger the epel-testing repo install. (the whole yum repo management by hand is tedious.)
