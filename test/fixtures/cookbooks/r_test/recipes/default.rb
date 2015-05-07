# config r and cran package here

r 'default' do
  enable_cran_repo 'cran.stat.ucla.edu'
end

cran 'getopt' do
  repo 'http://cran.stat.ucla.edu'
  action [:install, :upgrade]
end
