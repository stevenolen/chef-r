require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class Cran < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      include RCookbook::Helpers

      action :create do
        execute "CRAN: create #{new_resource.name}" do
          command cran_install_package
          not_if cran_package_exists
        end
      end

      action :delete do
        execute "CRAN: delete #{new_resource.name}" do
          command "/usr/bin/R --slave -e 'remove.packages(\"#{new_resource.name}\")'"
          only_if cran_package_exists
        end
      end

      action :upgrade do
        execute "CRAN: upgrade #{new_resource.name}" do
          command cran_install_package
          # note the lack of idempotency.
        end
      end
    end
  end
end
