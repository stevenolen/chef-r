require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class R < Chef::Resource::LWRPBase
      self.resource_name = :r
      actions :create, :delete
      default_action :create

      attribute :instance, kind_of: String, name_attribute: true
      attribute :version, kind_of: String, default: nil
      attribute :site_profile, kind_of: Array, default: []
      attribute :enable_cran_repo, kind_of: String, default: nil
      attribute :source, kind_of: [TrueClass, FalseClass], default: false
      attribute :source_dir, kind_of: String, default: '/usr/local/lib/R'
      attribute :source_config, kind_of: String, default: nil
    end
  end
end
