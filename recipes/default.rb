#
# Cookbook Name:: cbora12cclt
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#


Chef::Recipe.send(:include, General::InstallChecks)

#------------------------------------------------
# Check if already installed, proceed only if not
markerFile=node[:ora_client12c][:oraHome]

if already_installed?(markerFile)

  execute 'Log install-check message to /tmp/oracle_client_installed_check.file' do
    command "echo Oracle client seems to be already installed at #{markerFile}.  Check before re-run > /tmp/oracle_client_installed_check.file"
  end

  Chef::Log.warn("Oracle client seems already installed - NOT CONTINUING - found " + markerFile)

  return

else

  execute 'Log install-check message to /tmp/oracle_client_installed_check.file' do
    command "echo Oracle client is not installed.  Can install at #{markerFile} > /tmp/oracle_client_installed_check.file"
  end

  Chef::Log.info("Oracle client is not installed.  Can install at " + markerFile)

end


#--------------------------------------------------
# Check if /u01 and /u02 filesystems exist or not
# IF THEY DONT EXIST create or exit based on the attribute createFsDirIfMissing

if ( !already_installed?('/u01') || !already_installed?('/u02') ) 
  if !node[:createFsDirIfMissing]

    execute 'Log f/s check message to /tmp/oracle_client_installed_check.file' do
      command "echo Filesystems /u01 or /u02 do not exist, but you have chosen not to create them by this program - so, NOT CONTINUING >> /tmp/oracle_client_installed_check.file"
    end

    Chef::Log.warn("Filesystems /u01 or /u02 do not exist, but you have chosen not to create them by this program - so, NOT CONTINUING")
    return

  else
        Chef::Log.info("Filesystems /u01 or /u02 do not exist, and you have chosen to create them by this program - will create and install")
  end

end

#-------------------------------------
# If all checks fine, and good to go, run the install recipes
include_recipe 'cbora12cclt::oracle_users_groups_dirs_unix'
include_recipe 'cbora12cclt::oracle_client_install_12c'