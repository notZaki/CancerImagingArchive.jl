using CancerImagingArchive, DataFrames
using Test

#######
# SETUP
#######

# Use global variable for filenames because we want to delete them if they already exist
zip_file = "test.zip"
dicom_file = "test.dcm"
csv_file = "test.csv"
json_file = "test.json"

for file in [zip_file, dicom_file, csv_file, json_file]
    rm(file, force = true)
end

# Helper function for comparing CSV/DataFrames vs JSON/DictionaryArrays
function compare_csv_vs_json(csv, json; max_names = Inf)
    names_in_csv = find_names_in_csv(csv)
    names_in_json = find_names_in_json(json)
    @test length(json) == length(csv[!, names_in_csv[1]])
    @test length(names_in_json) == length(names_in_csv)
    if length(names_in_json) > max_names
        # Some cases have too many rows and they are not directly comparable because of types
        names_in_json = names_in_json[1:max_names]
        names_in_csv = names_in_csv[1:max_names]
    end
    for (idx, json_element) in enumerate(json)
        for name in names_in_csv
            if ismissing(csv[!, name][idx])
                # Missing entries lead to this messy situation. Just check if both json/csv are empty/missing
                @test isempty(json_element) || isempty(json_element[string(name)])
                @test ismissing(csv[!, name][idx])
            else
                @test csv[!, name][idx] == json_element[string(name)]
            end
        end
    end
    return nothing
end

function find_names_in_csv(csv)
    names_in_csv = names(csv)
    if :AnnotationsFlag in names_in_csv
        # This field occurs in csv but not json, so remove it
        select!(csv, Not([:AnnotationsFlag]))
    end
    return names(csv)
end

function find_names_in_json(json_array)
    # JSON names get ignored if the entry is missing so we can't just do collect(keys(json_array[1]))
    found_names = []
    num_names = 0
    for json in json_array
        cur_names = keys(json)
        if length(cur_names) > num_names
            found_names = collect(cur_names)
            num_names = length(found_names)
        end
    end
    return found_names
end

###############################################################################

@testset "Queries - Collection" begin
    @test_throws ErrorException tcia_collections(format = "unknown")
    collections_csv = tcia_collections()
    collections_json = tcia_collections(format = "json")
    @test length(collections_json) > 90
    compare_csv_vs_json(collections_csv, collections_json)
end

@testset "Queries - Modalities" begin
    @test length( tcia_modalities(collection = "TCGA-GBM", format = "json") ) > 2
    @test length( tcia_modalities(bodypart = "BREAST", format = "json") ) > 5
    compare_csv_vs_json(
        tcia_modalities(collection = "TCGA-GBM", bodypart = "BRAIN"),
        tcia_modalities(collection = "TCGA-GBM", bodypart = "BRAIN", format = "json"))
end

@testset "Queries - BodyParts" begin
    @test "BRAIN" in tcia_bodyparts(modality = "MR").BodyPartExamined
    compare_csv_vs_json(
        tcia_bodyparts(collection = "CPTAC-HNSCC"),
        tcia_bodyparts(collection = "CPTAC-HNSCC", format = "json"))
end

@testset "Queries - Manufacturers" begin
    compare_csv_vs_json(
        tcia_manufacturers(collection = "TCGA-KICH", modality = "MR"),
        tcia_manufacturers(collection = "TCGA-KICH", modality = "MR", format = "json"))
    compare_csv_vs_json(
        tcia_manufacturers(bodypart = "BREAST"),
        tcia_manufacturers(bodypart = "BREAST", format = "json"))
end

@testset "Queries - Patients" begin
    compare_csv_vs_json(
        tcia_patients(collection = "TCGA-THCA"),
        tcia_patients(collection = "TCGA-THCA", format = "json"))

    # Following criteria should only find one patient
    found_patient = tcia_patients_by_modality(collection = "ACRIN-FLT-Breast", modality = "OT")
    @test length(found_patient.PatientID) == 1
    @test found_patient.PatientID[1] == "ACRIN-FLT-Breast_066"

    # Following criteria should find at least two patients
    new_gbm_patients = tcia_newpatients(collection = "TCGA-GBM", date = "2015-01-01", format = "json")
    @test length(new_gbm_patients) > 1
end

@testset "Queries - Studies" begin
    # The CSV version requires a few manual changes, so we do them first
    studies_csv = tcia_studies(collection = "TCGA-SARC")
    # 1. Convert the date to plain strings so that they can be compared with the json version
    studies_csv.StudyDate = string.(studies_csv.StudyDate)
    # 2. Remove the escape characters in the string. These occur in the study description
    for (idx, description) in enumerate(studies_csv.StudyDescription)
        studies_csv.StudyDescription[idx] = replace(description, "\\" => "")
    end

    compare_csv_vs_json(
        studies_csv,
        tcia_studies(collection = "TCGA-SARC", format = "json"))

    # Following criteria should find at least three series
    @test length(tcia_newstudies(collection="TCGA-GBM", date="2015-01-01", format="json")) > 2
end

@testset "Queries - Series" begin
    compare_csv_vs_json(
        tcia_series(collection = "TCGA-THCA"),
        tcia_series(collection = "TCGA-THCA", format = "json"), max_names = 3)
    compare_csv_vs_json(
        tcia_series(patient = "TCGA-QQ-A8VF"),
        tcia_series(patient = "TCGA-QQ-A8VF", format = "json"), max_names = 3)
    compare_csv_vs_json(
        tcia_series(study = "1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806"),
        tcia_series(study = "1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806", format = "json"), max_names = 3)
    compare_csv_vs_json(
        tcia_series(bodypart = "CHEST", modality = "CT", manufacturer = "TOSHIBA"),
        tcia_series(bodypart = "CHEST", modality = "CT", manufacturer = "TOSHIBA", format = "json"), max_names = 3)

    # Can not use compare_csv_vs_json() on tcia_series_size() because TotalSizeInBytes has different types
    dce_series_json = tcia_series_size(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948", format="json")[1]
    @test dce_series_json["TotalSizeInBytes"] == "149149266.000000"
    dce_series_csv = tcia_series_size(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948")
    @test dce_series_csv.TotalSizeInBytes[1] ≈ 149149266
    @test dce_series_csv.ObjectCount[1] == dce_series_json["ObjectCount"] == 1120
end

@testset "Queries - SOP" begin
    compare_csv_vs_json(
        tcia_sop(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948"),
        tcia_sop(series = "1.3.6.1.4.1.14519.5.2.1.4591.4001.241972527061347495484079664948", format = "json"))
end

@testset "Data Download" begin
    patient_studies = tcia_studies(collection = "TCGA-THCA")
    chosen_study = patient_studies.StudyInstanceUID[1]
    imaging_series = tcia_series(study = chosen_study)
    chosen_series = imaging_series.SeriesInstanceUID[1]
    series_sops = tcia_sop(series = chosen_series)
    chosen_sop = series_sops.SOPInstanceUID[1]

    tcia_images(series = chosen_series, file = zip_file)
    @test isfile(zip_file)
    @test filesize(zip_file) == 945849

    tcia_single_image(series = chosen_series, sop = chosen_sop, file = dicom_file)
    @test isfile(dicom_file)
    @test filesize(dicom_file) == 980794
end

@testset "Utilities - remove_empty!()" begin
    dict_potentialy_empty_values = Dict(1 => "", 2 => "hello", 3 => "b", 4 => "", 5 => "ye")
    CancerImagingArchive.remove_empty!(dict_potentialy_empty_values)
    nonempty_keys = []
    for (key, value) in dict_potentialy_empty_values
        @test !isempty(value)
        push!(nonempty_keys, key)
    end
    @test nonempty_keys == [2, 3, 5]
end

@testset "Utilities - Data writer" begin
    tabular_data = tcia_collections()
    dataframe_to_csv(dataframe = tabular_data, file = csv_file)
    @test isfile(csv_file)
    println("Size of csv file: $(filesize(csv_file))")
    @test filesize(csv_file) >= 1346

    dict_array = tcia_collections(format = "json")
    dictionary_to_json(dictionary = dict_array, file = json_file)
    @test isfile(json_file)
    println("Size of json file: $(filesize(json_file))")
    @test filesize(json_file) >= 4816
end
