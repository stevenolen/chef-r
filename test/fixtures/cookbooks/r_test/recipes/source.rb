# config r and cran package here

r 'default' do
  source true
  version '3.3.1'
  enable_cran_repo 'cran.stat.ucla.edu'
end

#r 'another' do
#  source true
#  version '2.15.3'
#  enable_cran_repo 'cran.stat.ucla.edu'
#end

#cran 'getopt' do
#  r_install 'default'
#  repo 'http://cran.stat.ucla.edu'
#  action [:install, :upgrade]
#end
