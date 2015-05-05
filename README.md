# R-cookbook

Provides an LWRP interface for installing/configuring R as well as packages from CRAN.

## Supported Platforms

TODO: List your supported platforms.

## Usage

### r_install

r do
  source false
  version
  directory
  site_profile_options
  source_config
end

### cran

cran 'somepackage' do
  # can we support version?
end

## License and Authors

Author:: Steve Nolen (<technolengy@gmail.com>)
