require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class MysqlClient
      class Ubuntu < Chef::Provider::MysqlClient
        def packages
          version = '5.5'
          if Chef::VersionConstraint.new('>= 15.04').include?(node['platform_version'])
            version = '5.7'
          end
          [ "mysql-client-#{version}", 'libmysqlclient-dev' ]
        end
      end
    end
  end
end
