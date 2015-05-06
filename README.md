# R-cookbook

Provides an LWRP interface for installing/configuring R as well as packages from CRAN.

## Supported Platforms

TODO: List your supported platforms.

## Usage

### r

The `r` LWRP will handle installing R on your system. While this will be extended to support source installation, it currently
supports package installation.

```ruby
r 'default' do
  enable_cran_repo 'http://cran.stat.ucla.edu' # supported only on debian/ubuntu.
  site_profile [
    'r <- getOption("repos"); r["CRAN"] <- "http://cran.stat.ucla.edu/"; options(repos = r)'
  ]
end
```

#### Notes

Slightly different functionality is allowed depending on your platform:

  * `Debian/Ubuntu`
    * you may supply a url to `enable_cran_repo` if you'd like to install R from the cran repo (detailed at the [cran site](http://cran.r-project.org/)). if not supplied, the default packages (which may be older) will be used.
  * `Fedora`
    * `enable_cran_repo` will be ignored
    * R will be installed from the standard Fedora repositories
  * `RHEL/CentOS`
    * `enable_cran_repo` will be ignored
    * The yum EPEL repository will be installed and R will be installed from EPEL.

The `site_profile` attribute is an Array of lines to be placed under `local({})` in your `Rprofile.site` file. Feel free to ignore this
attribute but you probably want to do something if you plan to use the `cran` LWRP.

### cran

The `cran` LWRP will handle the installation of R packages for your R installation. R/CRAN have some interesting limitations, so take a look at notes section below for details on this particular implementations.

```ruby
cran 'somepackage' do
  repo 'http://cran.stat.ucla.edu'
end
```

#### Notes

CRAN does not currently offer the ability to specify a version of a package to install. If you run `install.packages()` you get the latest version available. To make this a bit cleaner (and idempotent) the `cran` resource has three actions: `:install`, `:remove` and `:upgrade`. Supplying **no** action or just the `:install` action will result in ensuring a package is installed, but never upgrading. Additionally supplying the `:upgrade` action will always keep the package at the latest version (but doing so idempotently through the use of the `old.packages()` command in R).

R also has some trouble by default using cran to install packages without interactivity. To get around this, you can either use the `site_profile` attribute in the `r` LWRP above to specify a default CRAN repo for all users or supply the `repo` attribute which will be passed to `install.packages()`.

## TODO

This cookbook is still quite small in features! Future intended feature set follows!

  * support source install option (greatly increases platform support)
  * support install of specific R versions.
  * support remote_file location for cran package
  * spec test more platforms

## License and Authors

Author:: Steve Nolen (<technolengy@gmail.com>)
