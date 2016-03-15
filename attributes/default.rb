#
# Author: Gowrish.Mallipattana
#
# Attributes file default.rb for oracle installation
#
#

default['userShell']                  = '/bin/bash'
#default['userShell']                  = '/bin/ksh'

# This attribute is to create /u01 and /u02 if they are missing
# Usually, they should be actual filesystems and should not be creating directories instead
default['createFsDirIfMissing']       = false

default['oracle']['userName']         = 'oracle'
default['oracle']['userUid']          = '501'
default['oracle']['installGroup']     = 'oradba'
default['oracle']['groupGid']         = '2580'
default['oracle']['userHome']         = '/home/oracle'
default['oracle']['oraInventory']     = '/u01/app/oraInventory'
default['oracle']['oraBase']          = '/u02/app/oracle'
default['oracle']['tnsDir']           = '/usr/local/tns'

default['ora_client12c']['installUser']             = 'oracle'
default['ora_client12c']['oraHome']                 = '/u02/app/oracle/product/12.1.0.2.CL'
default['ora_client12c']['installType']             = 'Administrator'
default['ora_client12c']['responseFile']            = '/home/oracle/oracle_client_12c_unix.rsp'
default['ora_client12c']['runInstallerMsgFile']     = '/tmp/oracle12c_client_install.out'

default['ora_client12c']['installScreenOutputLog']  = '/tmp/oracle12c_client_install.out'

# Location of software in Artifactory
default['ora_client12c']['sourceSoftwareBundle'] = 'https://source.xyz.com/12.1.0.2/client/linuxamd64_12102_client.zip'

# Location of software - on the server
default['ora_client12c']['softwareFolder']          = '/oracle-software/Client-12c'
#default['ora_client12c']['softwareFolder']          = '/home/oracle/oracle-software/Client-12c'
#default['ora_client12c']['softwareFolder']          = '/vagrant'

default['ora_client12c']['softwareBundle']          = 'linuxamd64_12102_client.zip'
default['ora_client12c']['unzipDir']                = '/tmp/oracle12c_client_unzip'