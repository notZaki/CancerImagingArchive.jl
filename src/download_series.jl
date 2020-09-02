function _initialize_destination(destination, overwrite)
    if overwrite
        rm(destination; force = true, recursive = true)
    end
    if !isdir(destination)
        mkpath(destination)
    end
    return destination
end

function _append_to_path(destination, append)
  append = replace(append, r"[^0-9a-zA-Z]" => "")
  return joinpath(destination, append)
end

function download_series(series_id::AbstractString, destination = "./", overwrite = true)
    _initialize_destination(destination, overwrite)
    zip_file = joinpath(destination, "downloaded.zip")
    tcia_images(series = series_id, file = zip_file)
    unzip_command = `unzip -o $zip_file -d $destination`
    run(unzip_command)
    rm(zip_file)
    return destination
end

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

function download_series(series::Dict, destination = "./"; append_desc = true, overwrite = true)
    series_id = series["SeriesInstanceUID"]
    if append_desc 
        destination = _append_to_path(destination, series["SeriesDescription"])
    end
    return download_series(series_id, destination, overwrite)
end

function download_series(series_array::Array, destination = "./"; append_desc = true, overwrite = true)
    return [download_series(series, destination; append_desc=append_desc, overwrite=overwrite) for series in series_array]
end
