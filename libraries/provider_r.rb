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

      action :create do
        configure_package_repositories

        package_name_list.each do |pkg|
          package pkg
        end
      end
    end
  end
end
