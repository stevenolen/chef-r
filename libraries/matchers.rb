if defined?(ChefSpec)
  # config
  def create_r(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:r, :create, resource_name)
  end

  def create_cran(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cran, :create, resource_name)
  end
end
