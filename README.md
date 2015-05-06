# R-cookbook

Provides an LWRP interface for installing/configuring R as well as packages from CRAN.

## Supported Platforms

TODO: List your supported platforms.

## Usage

### r

```ruby
r do
  source false
  version
  directory
  site_profile [
    'r <- getOption("repos"); r["CRAN"] <- "http://cran.stat.ucla.edu/"; options(repos = r)'
  ]
  source_config
end
```

### cran

```ruby
cran 'somepackage' do
  # can we support version?
end
```

## License and Authors

Author:: Steve Nolen (<technolengy@gmail.com>)
