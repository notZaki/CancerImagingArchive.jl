<a href="#"><img src="./docs/src/assets/logo.svg" width="350" height="200"></img></a>
# CancerImagingArchive.jl

<!--
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://notZaki.github.io/CancerImagingArchive.jl/stable)
-->
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://notZaki.github.io/CancerImagingArchive.jl/dev)
[![Build Status](https://travis-ci.com/notZaki/CancerImagingArchive.jl.svg?branch=master)](https://travis-ci.com/notZaki/CancerImagingArchive.jl)
[![Codecov](https://codecov.io/gh/notZaki/CancerImagingArchive.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/notZaki/CancerImagingArchive.jl)
[![Coveralls](https://coveralls.io/repos/github/notZaki/CancerImagingArchive.jl/badge.svg?branch=master)](https://coveralls.io/github/notZaki/CancerImagingArchive.jl?branch=master)

A Julia interface for [The Cancer Imaging Archive (TCIA) REST-API](https://wiki.cancerimagingarchive.net/display/Public/TCIA+Programmatic+Interface+%28REST+API%29+Usage+Guide)

## Installation

The package can be installed by

```julia
julia> ]add CancerImagingArchive
```

## Usage

The [documentation pages](https://notZaki.github.io/CancerImagingArchive.jl/dev) provide details/examples of how to use the package.   

## Notes

This is **not** an official project of The Cancer Imaging Archive. If any problems are experienced with this package, then please open a [new issue here](https://github.com/notZaki/CancerImagingArchive.jl/issues).

Please follow the [Data Usage Policies and Restrictions](https://wiki.cancerimagingarchive.net/display/Public/Data+Usage+Policies+and+Restrictions) outlined in the TCIA wiki.

If this package is helpful, then great! There is no need to cite the package itself.  
However, any manuscript produced using data from TCIA should cite: 

1. TCIA [[link]](https://www.ncbi.nlm.nih.gov/pubmed/23884657)
    ```
    Clark K, Vendt B, Smith K, et al. The Cancer Imaging Archive (TCIA): Maintaining and Operating a Public Information Repository. Journal of Digital Imaging. 2013; 26(6): 1045-1057. doi: 10.1007/s10278-013-9622-7.
    ```
2. All citations specific to the datasets that were used. These details are mentioned on the [TCIA wiki](https://wiki.cancerimagingarchive.net/display/Public/Data+Usage+Policies+and+Restrictions). 
