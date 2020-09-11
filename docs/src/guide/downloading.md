```@setup ex
using CancerImagingArchive
```

# Data Download

Imaging data can be downloaded either as a `.zip` file containing an imaging series or as a DICOM `.dcm` file containing a single acquisition within an imaging series.

## Imaging series

### Selecting the imaging series

The SeriesInstanceUID is needed to download an imaging series. The below example selects one series from the [TCGA-THCA collection](https://wiki.cancerimagingarchive.net/display/Public/TCGA-THCA).

```@repl ex
patient_studies = tcia_studies(collection = "TCGA-THCA")
chosen_study = patient_studies.StudyInstanceUID[1]
imaging_series = tcia_series(study = chosen_study)
chosen_series = imaging_series.SeriesInstanceUID[1]
```

### Downloading the imaging series

Once the SeriesInstanceUID is known, the imaging data can be downloaded as a zip file by:
```@repl ex
zip_file = "output_file.zip"; # Can also be a path
tcia_images(series = chosen_series, file = zip_file)
```

### Convenience wrapper

The above steps will only download a zip file which then has to be extracted. 
This can be cumbersome when downloading multipled series, so the `download_series()` function is provided for convenience.

!!! note

    The `download_series()` assumes that the `unzip` utility is installed on the system. This can be verified by typing `unzip` in a terminal or `;unzip` in julia.
    ```

**Downloading a single series**

The following will download and extract the `chosen_series` (selected above) and extract the images in the current directory `./`.
```julia
julia> download_series(chosen_series, "./")
```

**Downloading multiple series**

The wrapper function can download multiple series from a Dataframe by
```julia
julia> series = tcia_series(collection = "AAPM-RT-MAC", patient = "RTMAC-LIVE-001")
julia> download_series(series, "./testdf")
```
or from an array of dictionaries by
```julia
julia> seriesjs = tcia_series(collection = "AAPM-RT-MAC", patient = "RTMAC-LIVE-001", format="json") 
julia> download_series(seriesjs, "./testjs")
```

## Single image

### Selecting the single image

To download a single image, both its SeriesInstanceUID and SOPInstanceUID must be known.
Continuing from the previous example, if we only wanted to download the first image in `chosen_series`, then:

```@repl ex
series_sops = tcia_sop(series = chosen_series)
chosen_sop = series_sops.SOPInstanceUID[1]
```

### Downloading the single image

Once the SeriesInstanceUID and SOPInstanceUID are known, the dicom file can be downloaded by:

```@repl ex
dicom_file = "output_file.dcm";
tcia_single_image(series = chosen_series, sop = chosen_sop, file = dicom_file)
```

```@setup ex
rm(zip_file)
rm(dicom_file)
```
