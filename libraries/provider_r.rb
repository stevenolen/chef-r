require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class R < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      include RCookbook::Helpers

      action :install do
        unless new_resource.source
          configure_package_repositories
          configure_cran_repo if new_resource.enable_cran_repo

          package_name_list.each do |pkg|
            package pkg
          end

          template "#{new_resource.instance}: creating Rprofile.site" do
            cookbook 'R'
            path "#{r_home}/etc/Rprofile.site"
            source 'Rprofile.site.erb'
            variables(
              resource: new_resource
            )
          end
        else
          # source install
          path = '/usr/local/lib/R/' + new_resource.version + '/'
          directory path do
            recursive true
          end

          configure_source_deps
          r_version = new_resource.version
          major_version = r_version.split('.').first
          ark "R" do
            url "http://#{new_resource.enable_cran_repo}/src/base/R-#{major_version}/R-#{r_version}.tar.gz"
            version r_version
            autoconf_opts ['--with-x=no', "--prefix=#{path}"]
            action [:install_with_make]
          end
        end
      end

      action :remove do
        package_name_list.each do |pkg|
          package pkg do
            action :remove
          end
        end
      end
    end
  end
end
