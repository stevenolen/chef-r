require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class Cran < Chef::Resource::LWRPBase
      self.resource_name = :cran
      actions :install, :remove, :upgrade
      default_action :install

      attribute :instance, kind_of: String, name_attribute: true
    end
  end
end