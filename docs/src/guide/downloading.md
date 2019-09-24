```@setup ex
push!(LOAD_PATH,"../../../src/")
using CancerImagingArchive
```

# Data Download

Imaging data can be downloaded either as a `.zip` file containing an imaging series or as a DICOM `.dcm` file containing a single acquisition within an imaging series.

## Imaging series

### Selecting the imaging series

The SeriesInstanceUID is needed to download an imaging series. The below example selects one series from the [TCGA-THCA collection](https://wiki.cancerimagingarchive.net/display/Public/TCGA-THCA).

```@repl ex
patient_studies = studies(collection = "TCGA-THCA")
chosen_study = patient_studies.StudyInstanceUID[1]
imaging_series = series(study = chosen_study)
chosen_series = imaging_series.SeriesInstanceUID[1]
```

### Downloading the imaging series

Once the SeriesInstanceUID is known, the imaging data can be downloaded as a zip file by:
```@repl ex
zip_file = "output_file.zip"; # Can also be a path
images(series = chosen_series, file = zip_file)
```

## Single image

### Selecting the single image

To download a single image, both its SeriesInstanceUID and SOPInstanceUID must be known.
Continuing from the previous example, if we only wanted to download the first image in `chosen_series`, then:

```@repl ex
series_sops = sop(series = chosen_series)
chosen_sop = series_sops.SOPInstanceUID[1]
```

### Downloading the single image

Once the SeriesInstanceUID and SOPInstanceUID are known, the dicom file can be downloaded by:

```@repl ex
dicom_file = "output_file.dcm";
single_image(series = chosen_series, sop = chosen_sop, file = dicom_file)
```

```@setup ex
rm(zip_file)
rm(dicom_file)
```
