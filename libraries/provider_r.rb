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
        configure_package_repositories

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
