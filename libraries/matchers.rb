if defined?(ChefSpec)
  # config
  def install_r(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:r, :install, resource_name)
  end

  def install_cran(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cran, :install, resource_name)
  end
end