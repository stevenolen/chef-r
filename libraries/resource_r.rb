require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class R < Chef::Resource::LWRPBase
      self.resource_name = :r
      actions :create, :delete
      default_action :create

      attribute :instance, kind_of: String, name_attribute: true
      attribute :source, kind_of: [TrueClass, FalseClass], default: false
      attribute :version, kind_of: String, default: '3.2.0'
      attribute :directory, kind_of: String, default: '/usr/lib/R'
      attribute :source_config, kind_of: String, default: nil
      attribute :site_profile, kind_of: Hash, default: nil
    end
  end
end
