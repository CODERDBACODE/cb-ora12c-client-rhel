#
# Recipe:: users-and-roles-for-oracle-unix
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute

# User and roles creation for Oracle installation

# Create groups - begin
# https://docs.chef.io/resource_group.html

# Common install group for all oracle related users
group node[:oracle][:installGroup] do
  action :create
  gid    node[:oracle][:groupGid]
end

user node[:oracle][:userName]  do
  comment 'Oracle DB and Client software owner'
  uid     node[:oracle][:userUid] 
  group   node[:oracle][:installGroup]
  home    node[:oracle][:userHome]
  shell   node[:userShell] 

  # Note - no password - only do sudo to oracle
  #password 'oracle'

end

# Create users - end

# Create Directories - begin
%w[ /home /u01 /u01/app /u02 /u02/app ].each do |path|
  directory path do
    owner  'root'
    group  'root'
    mode   '0755'
    action :create
  end
end

dirs = [node[:oracle][:oraInventory]]

dirs.each do |path|
  directory path do
    owner  node[:oracle][:userName]
    group  node[:oracle][:installGroup]
    mode   '0775'
    action :create
  end
end

#dirs = [node[:oracle][:userHome], node[:oracle][:oraBase], node[:ora_client12c][:softwareFolder]]
dirs = [node[:oracle][:userHome], node[:oracle][:oraBase]]

dirs.each do |path|
  directory path do
    owner  node[:oracle][:userName]
    group  node[:oracle][:installGroup]
    mode   '0755'
    action :create
  end
end

dirs = [node[:oracle][:tnsDir]]
dirs.each do |path|
  directory path do
    owner  node[:oracle][:userName]
    group  node[:oracle][:installGroup]
    mode   '0775'
    action :create
  end
end

# Create directories - end
