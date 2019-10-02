```@setup ex
using CancerImagingArchive
```

# Formats

Most functions in this module return either a DataFrame (default) or a Dictionary Array.
Both formats have their respective advantages and disadvantages.

## DataFrames/CSV

DataFrames display the results in a table and this is the default behaviour.
The table is useful for visually analysing the results.
For example, the studies in the [TCGA-SARC collection](https://wiki.cancerimagingarchive.net/display/Public/TCGA-SARC) can be obtained by:
```@example ex
studies_df = studies(collection = "TCGA-SARC")
```

### Manipulating the DataFrame object

The table can be manipulated using tools from the [DataFrames.jl](https://juliadata.github.io/DataFrames.jl/stable/) and [CSV.jl](https://juliadata.github.io/CSV.jl/stable/) packages.

Individual columns in a DataFrame object---suppose it is named `data_frame`---can be accessed by `data_frame.column_name` where the available column names are in `names(data_frame)`.
```@repl ex
names(studies_df)
studies_df.StudyDate
```

The table can also be filtered and sorted. As an example, the following lines will sort the previous table by the number of series and then remove the `StudyInstanceUID` and `PatientName` columns:
```@example ex
using DataFrames
studies_sorted_by_count = sort(studies_df, :SeriesCount)
select!(studies_sorted_by_count, Not([:StudyInstanceUID, :PatientName]))
```

### Saving DataFrame as CSV

The contents of the table can be written to a csv file by:
```@repl ex
dataframe_to_csv(dataframe = studies_df, file = "output_file.csv")
```

## DictionaryArray/JSON

Instead of a table, an array of dictionaries can be obtained by passing `format = "json"` as an argument when calling the query function.
For example, the DataFrame from the previous example could have been obtained as an array by:
```@example ex
studies_array = studies(collection = "TCGA-SARC", format = "json")
```

### Manipulating the Dictionary Array

The array can be manipulated by iterating over the elements. As an example, the following lines will collect patients that are less than 60 years old:
```@example ex
patients_below_60Y = []
for patient in studies_array
  if patient["PatientAge"] < "060Y"
    push!(patients_below_60Y, patient)
  end
end
# Print the new array:
patients_below_60Y
```

The available keys for each dictionary in the array are listed by:
```@repl ex
keys(studies_array[1])
```

### Saving Dictionary Array as JSON

The array can be written to a JSON file by
```@repl ex
dictionary_to_json(dictionary = studies_array, file = "output_file.json")
```

```@setup ex
rm("output_file.csv")
rm("output_file.json")
```

## Note on types

The DataFrames object tries to figure out the types from the input while the DictionaryArray just accepts whatever the API returns.
For a practical example of this, suppose we want to know the size of an imaging series; the DataFrame version will be
```@example ex
series_size(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948")
```
while the JSON version will be
```@repl ex
series_size(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948", format="json")[1]
```
The difference between the two is that the DataFrames version recognizes that `TotalSizeInBytes` is a number whereas the DictionaryArray displays it as a string (because the API returns it as a string).

DataFrames' ability to recognize types is usually helpful, but sometimes it can fail.
For example, in an anonymized dataset where patient names are replaced by numbers, the DataFrames object will incorrectly treat the names as numbers.

These differences are unlikely to cause problems in practice so it isn't something to be actively concerned about.
