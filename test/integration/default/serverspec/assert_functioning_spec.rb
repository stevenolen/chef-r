require 'serverspec'

set :backend, :exec

describe command('R -e "installed.packages()"') do
  its(:exit_status) { should eq 0 }
end
