#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Cookbook Name:: yum
# Recipe:: ius
#
# Copyright:: Copyright (c) 2011 Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

major       = node['platform_version'].to_i
epel        = node['sls_utils']['yum_install']['epel_release']
ius         = node['sls_utils']['yum_install']['ius_release']
epel_url    = "http://dl.fedoraproject.org/pub/epel/#{major}/x86_64/epel-release-#{major}-#{epel}.noarch.rpm"
ius_url     = "http://dl.iuscommunity.org/pub/ius/stable/CentOS/#{major}/i386/ius-release-#{ius}.ius.centos#{major}.noarch.rpm"
epel_file   = "#{Chef::Config[:file_cache_path]}/epel-release-#{major}-#{epel}.noarch.rpm"
ius_file    = "#{Chef::Config[:file_cache_path]}/ius-release-#{ius}.ius.el#{major}.noarch.rpm"

# install / cleanup epel
erf = remote_file epel_file do
    source epel_url
    not_if "rpm -qa | grep -q '^epel-release-'"
    action :nothing
end

erp = rpm_package "epel-release" do
    source epel_file
    only_if { ::File.exists?(epel_file) }
    action :nothing
end

file "epel-release-cleanup" do
    path epel_file
    action :delete
end

# install / cleanup ius
irf = remote_file ius_file do
    source ius_url
    not_if "rpm -qa | grep -q '^ius-release-'"
    action :nothing
end

irp = rpm_package "ius-release" do
    source ius_file
    only_if { ::File.exists?(ius_file) }
    action :nothing
end

file "ius-release-cleanup" do
    path ius_file
    action :delete
end

# clean cache
execute_yum_clean_all = execute "yum clean all" do
    action :nothing
end

# run durring compile time so the yum packages are available to other
# cookbooks that run durring compile time
# mainly, this is to ensure mysql packages are present for mysql::ruby recipe
epel_was_installed = false
ius_was_installed = false

erf.run_action(:create)
erp.run_action(:install)

if erp.updated_by_last_action?
    epel_was_installed = true
end

irf.run_action(:create)
irp.run_action(:install)

if irp.updated_by_last_action?
    ius_was_installed = true
end

# run clean cache if either repo was installed
# so they are available to other cookbooks
if epel_was_installed || ius_was_installed
    execute_yum_clean_all.run_action(:run)
end
