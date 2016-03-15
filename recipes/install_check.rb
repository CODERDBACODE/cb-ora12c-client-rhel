#
# Cookbook Name:: cbora12cclt
# Recipe:: install_chefk
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

Chef::Recipe.send(:include, General::InstallChecks)

oraHome=node[:ora_client12c][:oraHome]

#------------------------------------------------
# Using helper to check if already installed
#markerFile=node[:ora_client12c][:oraHome]+'/bin/sqlplus'
markerFile=node[:ora_client12c][:oraHome]

if already_installed?(markerFile)

  execute 'Oracle client seems to be already installed.  Check before re-run' do
    command "echo Oracle client seems to be already installed.  Check before re-run > /tmp/oracle_client_installed_check.file"
  end

  Chef::Log.warn("Oracle client exists already_installed? - NOT CONTINUING - Found " + markerFile)

  return

end

#--------------------------------------------------
# Check if /u01 and /u02 filesystems exist or not
# IF THEY DONT EXIST create or exit based on the attribute createFsDirIfMissing

if ( !already_installed?('/u01') || !already_installed?('/u02') ) 
  if !node[:createFsDirIfMissing]

    Chef::Log.warn("Filesystems /u01 or /u02 do not exist, but you have chosen not to create them by this program")
    return

  else
        Chef::Log.info("Filesystems /u01 or /u02 do not exist, and you have chosen to create them by this program")
  end

end
