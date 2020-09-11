function _initialize_destination(destination, overwrite)
    if overwrite
        rm(destination; force = true, recursive = true)
    end
    if !isdir(destination)
        mkpath(destination)
    end
    return destination
end

function _append_to_path(path, thing_to_append)
  thing_to_append = replace(thing_to_append, r"[^0-9a-zA-Z]" => "")
  return joinpath(path, thing_to_append)
end

"""
    download_series(series_id::AbstractString, destination::AbstractString = "./", overwrite::Boolean = true)

Downloads images belonging to series with `series_id` and extracts them to `destination` folder.
If the destination folder already exists, then it will be overwritten by default unless `overwrite = false`.
"""
function download_series(series_id::AbstractString, destination = "./", overwrite = true)
    _initialize_destination(destination, overwrite)
    zip_file = joinpath(destination, "downloaded.zip")
    tcia_images(series = series_id, file = zip_file)
    unzip_command = `unzip -o $zip_file -d $destination`
    run(unzip_command)
    rm(zip_file)
    return destination
end

"""
    download_series(df::DataFrame, destination::AbstractString = "./"; append_desc::Boolean = true, overwrite::Boolean = true)

Downloads all images from the series in the dataframe `df` and then extracts them to `destination` folder. 
The `df` can be obtained through the `tcia_series()` function.
By default, the series description will be appended to the path unless `append_desc = false`.
If the destination folder already exists, then it will be overwritten by default unless `overwrite = false`.
"""
function download_series(series_df::DataFrames.DataFrame, destination = "./"; append_desc = true, overwrite = true)
    return [download_series(row, destination; append_desc=append_desc, overwrite=overwrite) for row in eachrow(series_df)]
end

function download_series(series::DataFrames.DataFrameRow, destination = "./"; append_desc = true, overwrite = true)
    series_id = series.SeriesInstanceUID
    if append_desc 
        destination = _append_to_path(destination, series.SeriesDescription)
    end
    return download_series(series_id, destination, overwrite)
end


"""
    download_series(arr::Array, destination::AbstractString = "./"; append_desc::Boolean = true, overwrite::Boolean = true)

Downloads all images from the series in the array `arr` and then extracts them to `destination` folder.
The `arr` can be obtained through the `tcia_series(..., format = "json")` command.
By default, the series description will be appended to the path unless `append_desc = false`.
If the destination folder already exists, then it will be overwritten by default unless `overwrite = false`.
"""
function download_series(series_array::Array, destination = "./"; append_desc = true, overwrite = true)
    return [download_series(series, destination; append_desc=append_desc, overwrite=overwrite) for series in series_array]
end

function download_series(series::Dict, destination = "./"; append_desc = true, overwrite = true)
    series_id = series["SeriesInstanceUID"]
    if append_desc 
        destination = _append_to_path(destination, series["SeriesDescription"])
    end
    return download_series(series_id, destination, overwrite)
end
