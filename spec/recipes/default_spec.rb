require 'spec_helper'

describe 'r_test::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: 'r_install')
      .converge(described_recipe)
  end

  context 'stepping into r_install resource' do
  end
end
