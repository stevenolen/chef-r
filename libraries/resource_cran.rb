require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class Cran < Chef::Resource::LWRPBase
      self.resource_name = :cran
      actions :create, :delete, :upgrade
      default_action :create

      attribute :instance, kind_of: String, name_attribute: true
      attribute :repo, kind_of: String, default: nil
    end
  end
end
