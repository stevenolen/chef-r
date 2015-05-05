require 'chef/provider/lwrp_base'
# require_relative 'helpers'

class Chef
  class Provider
    class R < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      # include R::Helpers

      action :create do
        # no-op
      end
    end
  end
end
