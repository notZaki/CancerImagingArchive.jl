```@setup ex
using CancerImagingArchive
```

# Queries

Queries are useful for exploring the available imaging data.
The general hierarchy of the cancer imaging archive (TCIA) is:
```
Collection -> PatientID -> StudyInstanceUID -> SeriesInstanceUID -> SOPInstanceUID
```
To download images, the `SeriesInstanceUID` and/or `SOPInstanceUID` must be known.
The query functions are meant to help identify the relevant unique identifiers (UIDs)

Detailed information is available in the TCIA's user guide which includes a [list of available query endpoints](https://wiki.cancerimagingarchive.net/display/Public/TCIA+Programmatic+Interface+%28REST+API%29+Usage+Guide) and the [type of information returned](https://wiki.cancerimagingarchive.net/display/Public/TCIA+API+Return+Values) by each query.

!!! note

    As mentioned in the [Formats](@ref) section, each query returns either a DataFrame or a Dictionary Array. The current section will exclusively use the DataFrame output. That being said, a dictionary array can always be obtained by any of these functions by passing `format = "json"` as an input argument.

## All collections

The names of all available collections on TCIA is obtained by:
```@repl ex
tcia_collections()
```

## Imaging modalities

The imaging modalities in a specific collection and/or anatomy are listed by:
```@repl ex
tcia_modalities(collection = "TCGA-KIRP")
tcia_modalities(bodypart = "BRAIN")
tcia_modalities(collection = "CPTAC-HNSCC", bodypart = "HEAD")
```

!!! note

    Capitalization matters when passing in arguments, i.e. `bodypart = "BRAIN"` works but passing `bodypart = "brain"` will return an empty object. However, there are some cases where different versions are valid. As an example, passing `bodypart = Kidney` or `bodypart = "KIDNEY"` will both return valid (but different!) results. So although fully-capitalized body part names will work most of the time, do double-check if alternative spellings exist when using the `bodypart` argument (see next section for names)

## Anatomy/body parts

The anatomy scanned in a specific collection and/or modality are listed by:
```@repl ex
tcia_bodyparts(collection = "CPTAC-HNSCC")
tcia_bodyparts(modality = "CT")
tcia_bodyparts(collection = "CPTAC-SAR", modality = "MR")
tcia_bodyparts(collection = "CPTAC-SAR", modality = "CT")
```

!!! note

    There are inter- and intra-collection variations in how body parts are named and sometimes the names are uncommon---such as "J brzuszna" in the above example which translates to "abdominal cavity".

## Manufacturers

A list of scanner manufacturers for a specific collection/modality/anatomy is obtained by
```@repl ex
tcia_manufacturers(collection = "TCGA-KICH")
tcia_manufacturers(modality = "CT")
tcia_manufacturers(bodypart = "BREAST")
```
The same manufacturer can have different names, e.g. `Philips`/`Philips Medical Systems` and `SIEMENS`/`Siemens`.

## Patients

The patients in a given collection are listed by:
```@repl ex
patients(collection = "TCGA-SARC")
```

### Patients for specific modality

To get a patients for which a specific modality was used, a slightly different function is used:
```@repl ex
patients_by_modality(collection = "TCGA-SARC", modality = "CT")
patients_by_modality(collection = "TCGA-SARC", modality = "MR")
```

!!! note

    Although the functionality of `patients_by_modality()` could be combined into the `patients()` function, they use a different query endpoint so the two functions were given different names to keep that difference explicit.

### Patients added after specific date

In large collections, it can be useful to query patients that were added after a date specified as YYYY-MM-DD.
This is accomplished by:
```@repl ex
newpatients(collection = "TCGA-GBM", date = "2015-01-01")
```

## Patient studies

A list of visits/studies for a given collection/patient is obtained by:
```@repl ex
studies(collection = "TCGA-THCA")
studies(patient = "TCGA-QQ-A8VF")
```

If the unique identifier (UID) for a study is known (a.k.a. StudyInstanceUID), then that can also be used
```@repl ex
studies(study = "1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806")
```

### Patient studies added after specific data

A list of visits/studies that were added after some date, formatted by YYYY-MM-DD, can be obtained by:
```@repl ex
tcia_newstudies(collection="TCGA-GBM", date="2015-01-01")
```

## Imaging series

Each patient study consists of one or more imaging series which can be obtained by:
```@repl ex
tcia_series(collection = "TCGA-THCA")
tcia_series(patient = "TCGA-QQ-A8VF")
tcia_series(study = "1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806")
tcia_series(modality = "CT", manufacturer = "TOSHIBA")
tcia_series(bodypart = "EXTREMITY")
```
This query's importance is hinted by the smorgasbord of parameters it accepts. 
That's because this query returns the `SeriesInstanceUID` which is needed to download images.
Although the above examples only show `PatientID`, the query actually returns more information which is not shown because of limited screen space. 
The complete list of columns are:
```@repl ex
series_dataframe = tcia_series(patient = "TCGA-QQ-A8VF");
names(series_dataframe)
```

!!! note

    The entire table could have been printed by:
    ```julia
    show(series_dataframe, allrows = true, allcols = true)
    ```

!!! warning

    Passing `format = "json"` will result in one fewer column. This is because the `AnnotationsFlag` field is returned for CSV output but not for JSON. 

### Imaging series size

The size (in bytes) and number of images for a given imaging series is given by
```@repl ex
tcia_series_size(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948")
```

!!! warning

    It is recommended that `tcia_series_size()` should **not** be used with `format = json`. This is because the json version interprets the `TotalSizeInBytes` as string/text rather than a number.

## Service-Object Pairs (SOP)

Each imaging series consists of one or more images, each of which have a service-object-pair unique identifier (SOPInstanceUID).
These can be listed by
```@repl ex
sop(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948")
```
These identifiers are useful for accessing a specific image without having to download the entire imaging series.
