var documenterSearchIndex = {"docs":
[{"location":"functions/#Functions","page":"Functions","title":"Functions","text":"","category":"section"},{"location":"functions/","page":"Functions","title":"Functions","text":"This page briefly describes the functions exported by the package.","category":"page"},{"location":"functions/","page":"Functions","title":"Functions","text":"The function names in this module are in lowercase letters and sometimes underscores are used for longer function names. Most functions require keyword arguments, i.e. tcia_bodyparts(collection = collection_name) will work but tcia_bodyparts(collection_name) will not.","category":"page"},{"location":"functions/#Index","page":"Functions","title":"Index","text":"","category":"section"},{"location":"functions/","page":"Functions","title":"Functions","text":"","category":"page"},{"location":"functions/#Public-functions","page":"Functions","title":"Public functions","text":"","category":"section"},{"location":"functions/","page":"Functions","title":"Functions","text":"Modules = [CancerImagingArchive]","category":"page"},{"location":"functions/#CancerImagingArchive.dataframe_to_csv-Tuple{}","page":"Functions","title":"CancerImagingArchive.dataframe_to_csv","text":"dataframe_to_csv(; dataframe, file)\n\nWrites the information in a DataFrame object (dataframe) into a csv file (file).\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.dictionary_to_json-Tuple{}","page":"Functions","title":"CancerImagingArchive.dictionary_to_json","text":"dictionary_to_json(; dictionary, file)\n\nWrites the information in a Dictionary Array (dictionary) into a json file (file).\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.download_series","page":"Functions","title":"CancerImagingArchive.download_series","text":"download_series(df::DataFrame, destination::AbstractString = \"./\"; append_desc::Boolean = true, overwrite::Boolean = true)\n\nDownloads all images from the series in the dataframe df and then extracts them to destination folder.  The df can be obtained through the tcia_series() function. By default, the series description will be appended to the path unless append_desc = false. If the destination folder already exists, then it will be overwritten by default unless overwrite = false.\n\n\n\n\n\n","category":"function"},{"location":"functions/#CancerImagingArchive.download_series-2","page":"Functions","title":"CancerImagingArchive.download_series","text":"download_series(arr::Array, destination::AbstractString = \"./\"; append_desc::Boolean = true, overwrite::Boolean = true)\n\nDownloads all images from the series in the array arr and then extracts them to destination folder. The arr can be obtained through the tcia_series(..., format = \"json\") command. By default, the series description will be appended to the path unless append_desc = false. If the destination folder already exists, then it will be overwritten by default unless overwrite = false.\n\n\n\n\n\n","category":"function"},{"location":"functions/#CancerImagingArchive.download_series-3","page":"Functions","title":"CancerImagingArchive.download_series","text":"download_series(series_id::AbstractString, destination::AbstractString = \"./\", overwrite::Boolean = true)\n\nDownloads images belonging to series with series_id and extracts them to destination folder. If the destination folder already exists, then it will be overwritten by default unless overwrite = false.\n\n\n\n\n\n","category":"function"},{"location":"functions/#CancerImagingArchive.remove_empty!-Tuple{Dict}","page":"Functions","title":"CancerImagingArchive.remove_empty!","text":"remove_empty!(dictionary::Dict)\n\nRemoves dictionary keys with empty values. Used internally to remove empty queries.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_bodyparts-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_bodyparts","text":"tcia_bodyparts(; collection, modality, format = \"csv\")\n\nReturns the body parts examined in a given collection and/or by a given modality.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_collections-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_collections","text":"tcia_collections(; format = \"csv\")\n\nProvides names of all the collections on TCIA.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_images-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_images","text":"tcia_images(; series, file)\n\nDownloads the images for the given SeriesInstanceUID series as the given zip-file file.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_manufacturers-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_manufacturers","text":"tcia_manufacturers(; collection, modality, bodypart, format = \"csv\")\n\nReturns the hardware manufacturers for a given collection and/or modality and/or bodypart.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_modalities-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_modalities","text":"tcia_modalities(; collection, bodypart, format = \"csv\")\n\nReturns the modalities used in a given collection and/or for a given bodypart.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_newstudies-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_newstudies","text":"tcia_newstudies(; date, collection, patient, format = \"csv\")\n\nReturns new studies for a given collection that were added after a given date formatted as YYYY-MM-DD.     The patient ID can be optionally given.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_patients-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_patients","text":"tcia_patients(; collection, format = \"csv\")\n\nReturns the patients in a given collection.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_patients_by_modality-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_patients_by_modality","text":"tcia_patients(; collection, modality, format = \"csv\")\n\nReturns the patients in a given collection and modality (both inputs required).\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_series-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_series","text":"tcia_series(; collection, bodypart, manufacturer, modality, model, patient, series, study, format = \"csv\")\n\nReturns series information for a given collection, bodypart,manufactuer,modality,     manufacturermodel, patient, SeriesInstanceUID series, or StudyInstanceUID study.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_series_size-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_series_size","text":"tcia_series_size(; series, format = \"csv\")\n\nReturns the total byte size and the number of objects in the given SeriesInstanceUID series.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_single_image-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_single_image","text":"tcia_single_image(; series, sop, file)\n\nDownloads a single DICOM image for the given SeriesInstanceUID series and SOPInstanceUID sop.     The DICOM file is saved as file.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_sop-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_sop","text":"tcia_sop(; series, format = \"csv\")\n\nReturns the SOPInstanceUIDs for the given SeriesInstanceUID series.\n\n\n\n\n\n","category":"method"},{"location":"functions/#CancerImagingArchive.tcia_studies-Tuple{}","page":"Functions","title":"CancerImagingArchive.tcia_studies","text":"tcia_studies(; collection, patient, study, format = \"csv\")\n\nReturns the patient studies for a given collection and/or patient and/or study.\n\n\n\n\n\n","category":"method"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"using CancerImagingArchive","category":"page"},{"location":"guide/downloading/#Data-Download","page":"Data Download","title":"Data Download","text":"","category":"section"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"Imaging data can be downloaded either as a .zip file containing an imaging series or as a DICOM .dcm file containing a single acquisition within an imaging series.","category":"page"},{"location":"guide/downloading/#Imaging-series","page":"Data Download","title":"Imaging series","text":"","category":"section"},{"location":"guide/downloading/#Selecting-the-imaging-series","page":"Data Download","title":"Selecting the imaging series","text":"","category":"section"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"The SeriesInstanceUID is needed to download an imaging series. The below example selects one series from the TCGA-THCA collection.","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"patient_studies = tcia_studies(collection = \"TCGA-THCA\")\nchosen_study = patient_studies.StudyInstanceUID[1]\nimaging_series = tcia_series(study = chosen_study)\nchosen_series = imaging_series.SeriesInstanceUID[1]","category":"page"},{"location":"guide/downloading/#Downloading-the-imaging-series","page":"Data Download","title":"Downloading the imaging series","text":"","category":"section"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"Once the SeriesInstanceUID is known, the imaging data can be downloaded as a zip file by:","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"zip_file = \"output_file.zip\"; # Can also be a path\ntcia_images(series = chosen_series, file = zip_file)","category":"page"},{"location":"guide/downloading/#Convenience-wrapper","page":"Data Download","title":"Convenience wrapper","text":"","category":"section"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"The above steps will only download a zip file which then has to be extracted.  This can be cumbersome when downloading multipled series, so the download_series() function is provided for convenience.","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"note: Note\nThe download_series() assumes that the unzip utility is installed on the system. This can be verified by typing unzip in a terminal or ;unzip in julia. ```","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"Downloading a single series","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"The following will download and extract the chosen_series (selected above) and extract the images in the current directory ./.","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"julia> download_series(chosen_series, \"./\")","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"Downloading multiple series","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"The wrapper function can download multiple series from a Dataframe by","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"julia> series = tcia_series(collection = \"AAPM-RT-MAC\", patient = \"RTMAC-LIVE-001\")\njulia> download_series(series, \"./testdf\")","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"or from an array of dictionaries by","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"julia> seriesjs = tcia_series(collection = \"AAPM-RT-MAC\", patient = \"RTMAC-LIVE-001\", format=\"json\") \njulia> download_series(seriesjs, \"./testjs\")","category":"page"},{"location":"guide/downloading/#Single-image","page":"Data Download","title":"Single image","text":"","category":"section"},{"location":"guide/downloading/#Selecting-the-single-image","page":"Data Download","title":"Selecting the single image","text":"","category":"section"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"To download a single image, both its SeriesInstanceUID and SOPInstanceUID must be known. Continuing from the previous example, if we only wanted to download the first image in chosen_series, then:","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"series_sops = tcia_sop(series = chosen_series)\nchosen_sop = series_sops.SOPInstanceUID[1]","category":"page"},{"location":"guide/downloading/#Downloading-the-single-image","page":"Data Download","title":"Downloading the single image","text":"","category":"section"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"Once the SeriesInstanceUID and SOPInstanceUID are known, the dicom file can be downloaded by:","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"dicom_file = \"output_file.dcm\";\ntcia_single_image(series = chosen_series, sop = chosen_sop, file = dicom_file)","category":"page"},{"location":"guide/downloading/","page":"Data Download","title":"Data Download","text":"rm(zip_file)\nrm(dicom_file)","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"using CancerImagingArchive","category":"page"},{"location":"guide/queries/#Queries","page":"Queries","title":"Queries","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"Queries are useful for exploring the available imaging data. The general hierarchy of the cancer imaging archive (TCIA) is:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"Collection -> PatientID -> StudyInstanceUID -> SeriesInstanceUID -> SOPInstanceUID","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"To download images, the SeriesInstanceUID and/or SOPInstanceUID must be known. The query functions are meant to help identify the relevant unique identifiers (UIDs)","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"Detailed information is available in the TCIA's user guide which includes a list of available query endpoints and the type of information returned by each query.","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"note: Note\nAs mentioned in the Formats section, each query returns either a DataFrame or a Dictionary Array. The current section will exclusively use the DataFrame output. That being said, a dictionary array can always be obtained by any of these functions by passing format = \"json\" as an input argument.","category":"page"},{"location":"guide/queries/#All-collections","page":"Queries","title":"All collections","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"The names of all available collections on TCIA is obtained by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_collections()","category":"page"},{"location":"guide/queries/#Imaging-modalities","page":"Queries","title":"Imaging modalities","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"The imaging modalities in a specific collection and/or anatomy are listed by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_modalities(collection = \"TCGA-KIRP\")\ntcia_modalities(bodypart = \"BRAIN\")\ntcia_modalities(collection = \"CPTAC-HNSCC\", bodypart = \"HEAD\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"note: Note\nCapitalization matters when passing in arguments, i.e. bodypart = \"BRAIN\" works but passing bodypart = \"brain\" will return an empty object. However, there are some cases where different versions are valid. As an example, passing bodypart = Kidney or bodypart = \"KIDNEY\" will both return valid (but different!) results. So although fully-capitalized body part names will work most of the time, do double-check if alternative spellings exist when using the bodypart argument (see next section for names)","category":"page"},{"location":"guide/queries/#Anatomy/body-parts","page":"Queries","title":"Anatomy/body parts","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"The anatomy scanned in a specific collection and/or modality are listed by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_bodyparts(collection = \"CPTAC-HNSCC\")\ntcia_bodyparts(modality = \"CT\")\ntcia_bodyparts(collection = \"CPTAC-SAR\", modality = \"MR\")\ntcia_bodyparts(collection = \"CPTAC-SAR\", modality = \"CT\")","category":"page"},{"location":"guide/queries/#Manufacturers","page":"Queries","title":"Manufacturers","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"A list of scanner manufacturers for a specific collection/modality/anatomy is obtained by","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_manufacturers(collection = \"TCGA-KICH\")\ntcia_manufacturers(modality = \"CT\")\ntcia_manufacturers(bodypart = \"BREAST\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"The same manufacturer can have different names, e.g. Philips/Philips Medical Systems and SIEMENS/Siemens.","category":"page"},{"location":"guide/queries/#Patients","page":"Queries","title":"Patients","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"The patients in a given collection are listed by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_patients(collection = \"TCGA-SARC\")","category":"page"},{"location":"guide/queries/#Patients-for-specific-modality","page":"Queries","title":"Patients for specific modality","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"To get a patients for which a specific modality was used, a slightly different function is used:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_patients_by_modality(collection = \"TCGA-SARC\", modality = \"CT\")\ntcia_patients_by_modality(collection = \"TCGA-SARC\", modality = \"MR\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"note: Note\nAlthough the functionality of tcia_patients_by_modality() could be combined into the tcia_patients() function, they use a different query endpoint so the two functions were given different names to keep that difference explicit.","category":"page"},{"location":"guide/queries/#Patients-added-after-specific-date","page":"Queries","title":"Patients added after specific date","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"In large collections, it can be useful to query patients that were added after a date specified as YYYY/MM/DD. This is accomplished by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_newpatients(collection = \"TCGA-GBM\", date = \"2015/01/01\")","category":"page"},{"location":"guide/queries/#Patient-studies","page":"Queries","title":"Patient studies","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"A list of visits/studies for a given collection/patient is obtained by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_studies(collection = \"TCGA-THCA\")\ntcia_studies(patient = \"TCGA-QQ-A8VF\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"If the unique identifier (UID) for a study is known (a.k.a. StudyInstanceUID), then that can also be used","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_studies(study = \"1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806\")","category":"page"},{"location":"guide/queries/#Patient-studies-added-after-specific-data","page":"Queries","title":"Patient studies added after specific data","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"A list of visits/studies that were added after some date, formatted by YYYY-MM-DD, can be obtained by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_newstudies(collection=\"TCGA-GBM\", date=\"2015-01-01\")","category":"page"},{"location":"guide/queries/#Imaging-series","page":"Queries","title":"Imaging series","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"Each patient study consists of one or more imaging series which can be obtained by:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_series(collection = \"TCGA-THCA\")\ntcia_series(patient = \"TCGA-QQ-A8VF\")\ntcia_series(study = \"1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806\")\ntcia_series(modality = \"CT\", manufacturer = \"TOSHIBA\")\ntcia_series(bodypart = \"EXTREMITY\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"This query's importance is hinted by the smorgasbord of parameters it accepts.  That's because this query returns the SeriesInstanceUID which is needed to download images. Although the above examples only show PatientID, the query actually returns more information which is not shown because of limited screen space.  The complete list of columns are:","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"series_dataframe = tcia_series(patient = \"TCGA-QQ-A8VF\");\nnames(series_dataframe)","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"note: Note\nThe entire table could have been printed by:show(series_dataframe, allrows = true, allcols = true)","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"warning: Warning\nPassing format = \"json\" will result in one fewer column. This is because the AnnotationsFlag field is returned for CSV output but not for JSON. ","category":"page"},{"location":"guide/queries/#Imaging-series-size","page":"Queries","title":"Imaging series size","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"The size (in bytes) and number of images for a given imaging series is given by","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_series_size(series = \"1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"warning: Warning\nIt is recommended that tcia_series_size() should not be used with format = json. This is because the json version interprets the TotalSizeInBytes as string/text rather than a number.","category":"page"},{"location":"guide/queries/#Service-Object-Pairs-(SOP)","page":"Queries","title":"Service-Object Pairs (SOP)","text":"","category":"section"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"Each imaging series consists of one or more images, each of which have a service-object-pair unique identifier (SOPInstanceUID). These can be listed by","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"tcia_sop(series = \"1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948\")","category":"page"},{"location":"guide/queries/","page":"Queries","title":"Queries","text":"These identifiers are useful for accessing a specific image without having to download the entire imaging series.","category":"page"},{"location":"#Introduction","page":"Introduction","title":"Introduction","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"The CancerImagingArchive.jl module provides a Julia interface for exploring and downloading imaging data from The Cancer Imaging Archive (TCIA) via their REST API.","category":"page"},{"location":"#Installation","page":"Introduction","title":"Installation","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"This module can be installed by:","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"julia> ]add CancerImagingArchive","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"Once installed, the package can be loaded via","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"julia> using CancerImagingArchive","category":"page"},{"location":"#Usage","page":"Introduction","title":"Usage","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"The module contains about a dozen Functions and a guide with some examples is included in the next section.","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"using CancerImagingArchive","category":"page"},{"location":"guide/formats/#Formats","page":"Formats","title":"Formats","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"Most functions in this module return either a DataFrame (default) or a Dictionary Array. Both formats have their respective advantages and disadvantages.","category":"page"},{"location":"guide/formats/#DataFrames/CSV","page":"Formats","title":"DataFrames/CSV","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"DataFrames display the results in a table and this is the default behaviour. The table is useful for visually analysing the results. For example, the studies in the TCGA-SARC collection can be obtained by:","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"studies_df = tcia_studies(collection = \"TCGA-SARC\")","category":"page"},{"location":"guide/formats/#Manipulating-the-DataFrame-object","page":"Formats","title":"Manipulating the DataFrame object","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The table can be manipulated using tools from the DataFrames.jl and CSV.jl packages.","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"Individual columns in a DataFrame object–-suppose it is named data_frame–-can be accessed by data_frame.column_name where the available column names are in names(data_frame).","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"names(studies_df)\nstudies_df.StudyDate","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The table can also be filtered and sorted. As an example, the following lines will sort the previous table by the number of series and then remove the StudyInstanceUID and PatientName columns:","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"using DataFrames\nstudies_sorted_by_count = sort(studies_df, :SeriesCount)\nselect!(studies_sorted_by_count, Not([:StudyInstanceUID, :PatientName]))","category":"page"},{"location":"guide/formats/#Saving-DataFrame-as-CSV","page":"Formats","title":"Saving DataFrame as CSV","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The contents of the table can be written to a csv file by:","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"dataframe_to_csv(dataframe = studies_df, file = \"output_file.csv\")","category":"page"},{"location":"guide/formats/#DictionaryArray/JSON","page":"Formats","title":"DictionaryArray/JSON","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"Instead of a table, an array of dictionaries can be obtained by passing format = \"json\" as an argument when calling the query function. For example, the DataFrame from the previous example could have been obtained as an array by:","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"studies_array = tcia_studies(collection = \"TCGA-SARC\", format = \"json\")","category":"page"},{"location":"guide/formats/#Manipulating-the-Dictionary-Array","page":"Formats","title":"Manipulating the Dictionary Array","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The array can be manipulated by iterating over the elements. As an example, the following lines will collect patients that are less than 60 years old:","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"patients_below_60Y = []\nfor patient in studies_array\n  if patient[\"PatientAge\"] < \"060Y\"\n    push!(patients_below_60Y, patient)\n  end\nend\n# Print the new array:\npatients_below_60Y","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The available keys for each dictionary in the array are listed by:","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"keys(studies_array[1])","category":"page"},{"location":"guide/formats/#Saving-Dictionary-Array-as-JSON","page":"Formats","title":"Saving Dictionary Array as JSON","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The array can be written to a JSON file by","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"dictionary_to_json(dictionary = studies_array, file = \"output_file.json\")","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"rm(\"output_file.csv\")\nrm(\"output_file.json\")","category":"page"},{"location":"guide/formats/#Note-on-types","page":"Formats","title":"Note on types","text":"","category":"section"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The DataFrames object tries to figure out the types from the input while the DictionaryArray just accepts whatever the API returns. For a practical example of this, suppose we want to know the size of an imaging series; the DataFrame version will be","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"tcia_series_size(series = \"1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948\")","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"while the JSON version will be","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"tcia_series_size(series = \"1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948\", format=\"json\")[1]","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"The difference between the two is that the DataFrames version recognizes that TotalSizeInBytes is a number whereas the DictionaryArray displays it as a string (because the API returns it as a string).","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"DataFrames' ability to recognize types is usually helpful, but sometimes it can fail. For example, in an anonymized dataset where patient names are replaced by numbers, the DataFrames object will incorrectly treat the names as numbers.","category":"page"},{"location":"guide/formats/","page":"Formats","title":"Formats","text":"These differences are unlikely to cause problems in practice so it isn't something to be actively concerned about.","category":"page"}]
}
