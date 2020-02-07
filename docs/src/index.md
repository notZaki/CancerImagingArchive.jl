## Introduction

The `CancerImagingArchive.jl` module provides a Julia interface for exploring and downloading imaging data from [The Cancer Imaging Archive (TCIA)](https://www.cancerimagingarchive.net/) via their [REST API](https://wiki.cancerimagingarchive.net/display/Public/TCIA+Programmatic+Interface+%28REST+API%29+Usage+Guide).

## Installation

This module can be installed by:
```julia
julia> ]add https://github.com/notZaki/CancerImagingArchive.jl.git#master
```
Once installed, the package can be loaded via
```julia
julia> using CancerImagingArchive
```

!!! note

    This module uses simple names for its functions, e.g. `tcia_studies()`, `tcia_images()`, `tcia_patients()`.

## Usage

The module contains about a dozen [Functions](@ref) and a guide with some examples is included in the next section.
