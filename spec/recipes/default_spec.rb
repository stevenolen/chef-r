require 'spec_helper'

describe 'r_test::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['r', 'cran'])
      .converge(described_recipe)
  end

  context 'stepping into r[default] resource' do
    before do
      stub_command("/usr/bin/R --slave -e 'find.package(\"getopt\")'").and_return(false)
    end
    before do
      stub_command("/usr/bin/R --slave -e 'old.packages(repos = c(\"http://cran.stat.ucla.edu\"))' | grep getopt").and_return(false)
    end
    
    it 'installs r-base' do
      expect(chef_run).to install_package('r-base')
    end

    it 'installs r-base-dev' do
      expect(chef_run).to install_package('r-base-dev')
    end

    it 'creates Rprofile.site file' do
      expect(chef_run).to create_template('/usr/lib/R/etc/Rprofile.site')
    end

    it 'installs getopt R package' do
      expect(chef_run).to run_execute("CRAN: create getopt")
    end

    it 'does not upgrade getopt R package' do
      expect(chef_run).to_not run_execute("CRAN: upgrade getopt")
    end
  end
end
