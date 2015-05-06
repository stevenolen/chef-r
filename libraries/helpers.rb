module RCookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def configure_package_repositories
      # we need to enable epel if centos,rhel. but not fedora.
      return unless %w(rhel).include? node['platform_family']
      yum_repository 'epel' do
        mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
        description 'Extra Packages for Enterprise Linux 6 - $basearch'
        enabled true
        gpgcheck true
        gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
      end
    end

    def configure_cran_repo
      # unsupported on non-deb distros
      return unless %w(debian).include? node['platform_family']
      apt_repository new_resource.enable_cran_repo do
        uri "http://#{new_resource.enable_cran_repo}/bin/linux/#{node['platform']}"
        distribution cran_apt_distribution
        key '381BA480'
        keyserver 'keyserver.ubuntu.com'
        action :add
      end
    end

    def package_name_list
      return ['r-base', 'r-base-dev'] if node['platform_family'] == 'debian'
      ['R']
    end

    def cran_apt_distribution
      case node['platform']
      when 'ubuntu'
        node['lsb']['codename']
      when 'debian'
        # add support for R < 3
        "#{node['lsb']['codename']}-cran3"
      end
    end
  end
end
