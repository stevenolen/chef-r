module RCookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def configure_package_repositories
      # we need to enable epel if centos,rhel. but not fedora.
      return unless %w(rhel).include? node['platform_family']
      # do the rest of that work.
    end

    def package_name
      'r-base' if node['platform_family'] == 'debian'
      'R'
    end
  end
end