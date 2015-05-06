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

    def cran_package_exists
      "/usr/bin/R --slave -e 'find.package(\"#{new_resource.name}\")'"
    end

    def cran_package_outdated
      return "/usr/bin/R --slave -e 'old.packages(repos = c(\"#{new_resource.repo}\"))' | grep #{new_resource.name}" if new_resource.repo
      "/usr/bin/R --slave -e 'old.packages()' | grep #{new_resource.name}"
    end

    def cran_install_package
      return "/usr/bin/R --slave -e 'install.packages(\"#{new_resource.name}\", repos = c(\"#{new_resource.repo}\"))'" if new_resource.repo
      "/usr/bin/R --slave -e 'install.packages(\"#{new_resource.name}\")'"
    end

    def r_home
      if new_resource.source
        # source install not yet supported
      else
        case node['platform_family']
        when 'rhel', 'fedora'
          # rhel/fedora x86-64 uses a different dir to install R...
          return '/usr/lib64/R' if node['kernel']['machine'] == 'x86_64'
          '/usr/lib/R'
        else
          '/usr/lib/R'
        end
      end
    end
  end
end
