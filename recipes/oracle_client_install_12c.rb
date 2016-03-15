#
# Author: Gowrish.Mallipattana
#
# Oracle client installation recipe
#
#

# Variables set for use by templates and others
oraInventory              =   node[:oracle][:oraInventory]
oraHome                   =   node[:ora_client12c][:oraHome]
responseFile              =   node[:ora_client12c][:responseFile] 
softwareFolder            =   node[:ora_client12c][:softwareFolder]
softwareBundle            =   node[:ora_client12c][:softwareBundle]
artifactorySoftwareBundle =   node[:ora_client12c][:artifactorySoftwareBundle]
unzipDir                  =   node[:ora_client12c][:unzipDir] 
runInstaller              =   node[:ora_client12c][:unzipDir] + '/client/runInstaller'
runInstallerMsgFile       =   node[:ora_client12c][:runInstallerMsgFile]

# Create the response file from template
template node[:ora_client12c][:responseFile] do
  source 'oracle_client_12c_unix_rsp.erb'
   owner node[:oracle][:userName] 
   group node[:oracle][:installGroup]
    mode '0755'
    variables({
     :installGroup  => node[:oracle][:installGroup],
     :installUser   => node[:ora_client12c][:installUser],
     :oraInventory  => node[:oracle][:oraInventory],
     :oraBase       => node[:oracle][:oraBase],
     :oraHome       => node[:ora_client12c][:oraHome],
     :installType   => node[:ora_client12c][:installType],
     :hostname      => node[:hostname]
  })
end

if !File.exists?"#{node[:ora_client12c][:softwareFolder]}"
  execute 'Create software bundle directory for oracle software bundle' do
    command "mkdir -p #{node[:ora_client12c][:softwareFolder]}"
  end

end


execute 'Change owner to oracle of software bundle directory' do
  command "chown -R #{node[:ora_client12c][:installUser]} #{node[:ora_client12c][:softwareFolder]}"
end

if !File.exists?"#{unzipDir}"
  execute 'Create unzip directory for oracle software bundle' do
    command "su #{node[:ora_client12c][:installUser]} -c 'mkdir -p #{unzipDir}' "
  end
end

if !File.exists?"#{softwareFolder}/#{softwareBundle}"
  execute 'Download software from Artifactory' do
    user "#{node[:ora_client12c][:installUser]}"
    command "curl -o #{softwareFolder}/#{softwareBundle}  #{node[:ora_client12c][:sourceSoftwareBundle]}"
  end
end

execute 'Unzip oracle software bundle' do
  command "su #{node[:ora_client12c][:installUser]} -c 'unzip #{softwareFolder}/#{softwareBundle} -d #{unzipDir}' "
end

execute 'Install oracle software bundle' do
  command "su #{node[:ora_client12c][:installUser]} -c '#{runInstaller} -silent -waitforcompletion -noconfig -ignoreSysPrereqs -ignorePrereq -responseFile #{responseFile} > #{runInstallerMsgFile} 2>> #{runInstallerMsgFile}' "
end

execute 'Sleep a while for all filecopy to end' do
  command "sleep 60"
end

execute 'Run root shell' do
  user "root"
  command "#{oraHome}/root.sh"
end

execute 'Run orainstRoot shell' do
  command "sudo su - root -c '#{oraInventory}/orainstRoot.sh'"
end

execute 'Cleanup unzipped oracle software bundle' do
  command "su #{node[:ora_client12c][:installUser]} -c 'rm -rf #{unzipDir}' "
end