if defined?(ChefSpec)
  def install_r(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:r, :install, resource_name)
  end

  def remove_r(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:r, :remove, resource_name)
  end

  def install_cran(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cran, :install, resource_name)
  end

  def remove_cran(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cran, :remove, resource_name)
  end

  def upgrade_cran(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cran, :upgrade, resource_name)
  end
end
