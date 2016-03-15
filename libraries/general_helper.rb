#                                                                                         
# Author: Gowrish.Mallipattana                                                            
#                                                                                         
# Helper for general purpose work                                 
#

module General
  module InstallChecks

    # Generic check
    def already_installed? (installedFile)

      if File.exist?(installedFile)
      then
        Chef::Log.warn("Install check - File or folder exists.  Found - " + installedFile)
        return true
      else
        Chef::Log.info("Install check - File or folder does not exist.  Did not find - " + installedFile)
        return false
        #return 1
      end
    end

  end
end