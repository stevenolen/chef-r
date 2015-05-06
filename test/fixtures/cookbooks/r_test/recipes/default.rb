# config r and cran package here

r 'default' do

end

cran 'getopt' do
  repo 'http://cran.stat.ucla.edu'
  action [:install, :upgrade]
end
