module MysqlCookbook
  module Helpers
    module Debian

      def include_dir
        '/etc/mysql/conf.d'
      end

      def pid_file
        "#{run_dir}/mysql.pid"
      end

      def prefix_dir
        '/usr'
      end

      def run_dir
        if Chef::VersionConstraint.new('>= 15.04').include?(node['platform_version'])
          return '/run/mysqld'
        end
        '/var/run/mysqld'
      end

      def pass_string
        if new_resource.parsed_server_root_password.empty?
          pass_string = ''
        else
          pass_string = '-p' + Shellwords.escape(new_resource.parsed_server_root_password)
        end

        pass_string = '-p' + ::File.open('/etc/.mysql_root').read.chomp if ::File.exist?('/etc/.mysql_root')
        pass_string
      end

      def socket_file
        "#{run_dir}/mysqld/mysqld.sock"
      end
    end
  end
end
