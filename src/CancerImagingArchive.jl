module CancerImagingArchive

using HTTP, CSV, DataFrames, JSON

export tcia_collections, tcia_modalities, tcia_bodyparts, tcia_manufacturers, tcia_studies, tcia_series, tcia_series_size
export tcia_patients, tcia_patients_by_modality, tcia_newpatients, tcia_newstudies, tcia_sop
export tcia_single_image, images
export dataframe_to_csv, dictionary_to_json

# const _host = "services.cancerimagingarchive.net/services/v3/TCIA/query"
const _host = "api.cancerimagingarchive.net/radiology"
const _format = "csv"
const _q = Dict(
    :collection => "Collection",
    :bodypart => "BodyPartExamined",
    :modality => "Modality",
    :patient => "PatientID",
    :study => "StudyInstanceUID",
    :series => "SeriesInstanceUID",
    :manufacturer => "Manufacturer",
    :model => "ManufacturerModelName",
    :date => "Date",
    :sop => "SOPInstanceUID",
    :format => "format"
)

"""
    remove_empty!(dictionary::Dict)

Removes dictionary keys with empty values.
Used internally to remove empty queries.
"""
function remove_empty!(dictionary::Dict)
    for (key, value) in dictionary
        if isempty(value)
            delete!(dictionary, key)
        end
    end
end

"""
    tcia_collections(; format = "csv")

Provides names of all the collections on TCIA.
"""
function tcia_collections(; format = _format)
    endpoint = "/getCollectionValues"
    query = Dict(
        _q[:format] => format
        )
    return request(endpoint, query)
end

"""
    tcia_modalities(; collection, bodypart, format = "csv")

Returns the modalities used in a given `collection` and/or for a given `bodypart`.
"""
function tcia_modalities(; collection = "", bodypart = "", format = _format)
    endpoint = "/getModalityValues"
    query = Dict(
        _q[:collection] => collection,
        _q[:bodypart] => bodypart,
        _q[:format] => format)
    return request(endpoint, query)
end

"""
    tcia_bodyparts(; collection, modality, format = "csv")

Returns the body parts examined in a given `collection` and/or by a given `modality`.
"""
function tcia_bodyparts(; collection = "", modality = "", format = _format)
    endpoint = "/getBodyPartValues"
    query = Dict(
        _q[:collection] => collection,
        _q[:modality] => uppercase(modality),
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_manufacturers(; collection, modality, bodypart, format = "csv")

Returns the hardware manufacturers for a given `collection` and/or `modality` and/or `bodypart`.
"""
function tcia_manufacturers(; collection = "", modality = "",  bodypart = "", format = _format)
    endpoint = "/getManufacturerValues"
    query = Dict(
        _q[:collection] => collection,
        _q[:bodypart] => bodypart,
        _q[:modality] => modality,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_patients(; collection, format = "csv")

Returns the patients in a given `collection`.
"""
function tcia_patients(; collection = "", format = _format)
    endpoint = "/getPatient"
    query = Dict(
        _q[:collection] => collection,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_patients(; collection, modality, format = "csv")

Returns the patients in a given `collection` and `modality` (both inputs required).
"""
function tcia_patients_by_modality(; collection::AbstractString, modality::AbstractString, format = _format)
    endpoint = "/PatientsByModality"
    query = Dict(
        _q[:collection] => collection,
        _q[:modality] => modality,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_studies(; collection, patient, study, format = "csv")

Returns the patient studies for a given `collection` and/or `patient` and/or `study`.
"""
function tcia_studies(; collection = "", patient = "", study = "", format = _format)
    endpoint = "/getPatientStudy"
    query = Dict(
        _q[:collection] => collection,
        _q[:patient] => patient,
        _q[:study] => study,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_series(; collection, bodypart, manufacturer, modality, model, patient, series, study, format = "csv")

Returns series information for a given `collection`, `bodypart, `manufactuer`, `modality`,
    manufacturer `model, `patient`, SeriesInstanceUID `series`, or StudyInstanceUID `study`.
"""
function tcia_series(; collection = "", bodypart = "", manufacturer = "", modality = "",
                  model = "", patient = "", series = "", study = "", format = _format)
    endpoint = "/getSeries"
    query = Dict(
        _q[:collection] => collection,
        _q[:bodypart] => bodypart,
        _q[:manufacturer] => manufacturer,
        _q[:modality] => modality,
        _q[:model] => model,
        _q[:patient] => patient,
        _q[:series] => series,
        _q[:study] => study,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_series_size(; series, format = "csv")

Returns the total byte size and the number of objects in the given SeriesInstanceUID `series`.
"""
function tcia_series_size(; series::AbstractString, format = _format)
    endpoint = "/getSeriesSize"
    query = Dict(
        _q[:series] => series,
        _q[:format] => format
        )
    return request(endpoint, query)
end

"""
    tcia_sop(; series, format = "csv")

Returns the SOPInstanceUIDs for the given SeriesInstanceUID `series`.
"""
function tcia_sop(; series::AbstractString, format = _format)
    endpoint = "/getSOPInstanceUIDs"
    query = Dict(
        _q[:series] => series,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    images(; series, file)

Downloads the images for the given SeriesInstanceUID `series` as the given zip-file `file`.
"""
function images(; series::AbstractString, file::AbstractString)
    endpoint = "/getImage"
    query = Dict(
        _q[:series] => series,
    )
    return request(endpoint, query, file=file)
end

"""
    tcia_single_image(; series, sop, file)

Downloads a single DICOM image for the given SeriesInstanceUID `series` and SOPInstanceUID `sop`.
    The DICOM file is saved as `file`.
"""
function tcia_single_image(; series::AbstractString, sop::AbstractString, file::AbstractString)
    endpoint = "/getSingleImage"
    query = Dict(
        _q[:series] => series,
        _q[:sop] => sop
    )
    return request(endpoint, query, file = file)
end

function tcia_newpatients(; collection::AbstractString, date::AbstractString, format = _format)
    endpoint = "/NewPatientsInCollection"
    query = Dict(
        _q[:collection] => collection,
        _q[:date] => date,
        _q[:format] => format
    )
    return request(endpoint, query)
end

"""
    tcia_newstudies(; date, collection, patient, format = "csv")

Returns new studies for a given `collection` that were added after a given `date` formatted as `YYYY-MM-DD`.
    The `patient` ID can be optionally given.
"""
function tcia_newstudies(; date::AbstractString, collection::AbstractString, patient = "", format = _format)
    endpoint = "/NewStudiesInPatientCollection"
    query = Dict(
        _q[:collection] => collection,
        _q[:date] => date,
        _q[:patient] => patient,
        _q[:format] => format
    )
    return request(endpoint, query)
end

function request(endpoint, query; file="")
    remove_empty!(query)
    uri = HTTP.URI(scheme="https", host=_host, path=endpoint, query=query)
    @assert HTTP.isvalid(uri) "Invalid URI: $(uri)"
    url = string(uri)
    if has_format(query, "csv")
        return _request_csv(url)
    elseif has_format(query, "json")
        return _request_json(url)
    elseif !isempty(file)
        return _request_image(url, file)
    else
        error("Not supported")
    end
end

has_format(query, format) = haskey(query, "format") && query["format"]==format

function _request_csv(url)
    r = HTTP.request("GET", url)
    return CSV.read(r.body, copycols=true)
end

function _request_json(url)
    r = HTTP.request("GET", url)
    return JSON.Parser.parse(String(r.body))
end

function _request_image(url, file)
    HTTP.open("GET", url) do http
        open(file, "w") do out
            write(out, http)
        end
    end
    return file
end

"""
    dataframe_to_csv(; dataframe, file)

Writes the information in a DataFrame object (`dataframe`) into a csv file (`file`).
"""
function dataframe_to_csv(; dataframe::DataFrame, file::AbstractString)
    CSV.write(file, dataframe)
    return
end

"""
    dictionary_to_json(; dictionary, file)

Writes the information in a Dictionary Array (`dictionary`) into a json file (`file`).
"""
function dictionary_to_json(; dictionary, file::AbstractString)
    open(file, "w") do io
        JSON.print(io, dictionary, 4)
    end
    return
end

end # module
