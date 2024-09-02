using CancerImagingArchive
using DataFrames
using Test

#######
# SETUP
#######

# Use global variable for filenames because we want to delete them if they already exist
testdatadir = "./testdata"
if isdir(testdatadir)
  rm(testdatadir, recursive=true)
end
mkdir(testdatadir)
zip_file = joinpath(testdatadir, "test.zip")
dicom_file = joinpath(testdatadir, "test.dcm")
csv_file = joinpath(testdatadir, "test.csv")
json_file = joinpath(testdatadir, "test.json")


# Helper function for comparing CSV/DataFrames vs JSON/DictionaryArrays
function compare_csv_vs_json(csv, json; max_names=Inf)
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
  # AnnotationsFlag field exists in csv but not json, so remove it for comparisons
  filter!(name -> name != "AnnotationsFlag", names_in_csv)
  return names_in_csv
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

# TEST UIDS
STUDY_UID = "1.3.6.1.4.1.14519.5.2.1.3023.4024.298690116465423805879206377806"
SERIES_UID = "1.3.6.1.4.1.14519.5.2.1.6834.5010.322628904903035357840500590726"


@testset "Queries - Collection" begin
  @test_throws ErrorException tcia_collections(format="unknown")
  collections_csv = tcia_collections()
  collections_json = tcia_collections(format="json")
  @test length(collections_json) > 100
  compare_csv_vs_json(collections_csv, collections_json)
end

@testset "Queries - Modalities" begin
  collection_tcga_sarc = tcia_modalities(collection="TCGA-SARC", format="json")
  collection_tcga_sarc_csv = tcia_modalities(collection="TCGA-SARC")
  collection_breast = tcia_modalities(bodypart="BREAST", format="json")
  @test length(collection_tcga_sarc) >= 2
  @test length(collection_breast) > 5
  compare_csv_vs_json(
    collection_tcga_sarc_csv,
    collection_tcga_sarc)
end

@testset "Queries - BodyParts" begin
  @test "BRAIN" in tcia_bodyparts(modality="MR").BodyPartExamined
  compare_csv_vs_json(
    tcia_bodyparts(collection="TCGA-SARC"),
    tcia_bodyparts(collection="TCGA-SARC", format="json"))
end

@testset "Queries - Manufacturers" begin
  compare_csv_vs_json(
    tcia_manufacturers(collection="TCGA-KICH", modality="MR"),
    tcia_manufacturers(collection="TCGA-KICH", modality="MR", format="json"))
end

@testset "Queries - Patients" begin
  @test nrow(tcia_patients(collection="TCGA-THCA")) > 5

  # Following criteria should only find one patient
  found_patient = tcia_patients_by_modality(collection="ACRIN-FLT-Breast", modality="OT")
  @test length(found_patient.PatientId) == 1
  @test found_patient.PatientId[1] == "ACRIN-FLT-Breast_066"

  # Following criteria should find at least two patients
  new_patients = tcia_newpatients(collection="TCGA-KIRP", date="2015/01/01", format="json")
  @test length(new_patients) > 1
end

@testset "Queries - Studies" begin
  studies_csv = tcia_studies(collection="TCGA-SARC")
  studies_json = tcia_studies(collection="TCGA-SARC", format="json")
  @test nrow(studies_csv) == length(studies_json)
  # Following criteria should find at least two series
  @test length(tcia_newstudies(collection="TCGA-KIRP", date="2015/01/01", format="json")) >= 2
end

@testset "Queries - Series" begin
  @test length(tcia_series(collection="TCGA-THCA", format="json")) > 20

  # SKIP: takes too long
  # tcia_series_size(series="1.2.840.113619.2.55.3.1930041893.617.1308206442.326.4")
end

@testset "Queries - SOP" begin
  @test length(tcia_sop(series=SERIES_UID, format="json")) > 40
end

@testset "Data Download" begin
  patient_studies = tcia_studies(collection="TCGA-THCA")
  chosen_study = patient_studies.StudyInstanceUID[1]
  imaging_series = tcia_series(study=chosen_study)
  chosen_series = imaging_series.SeriesInstanceUID[1]
  series_sops = tcia_sop(series=chosen_series)
  chosen_sop = series_sops.SOPInstanceUID[1]

  tcia_images(series=chosen_series, file=zip_file)
  @test isfile(zip_file)
  println("Size of zip file: $(filesize(zip_file))")

  tcia_single_image(series=chosen_series, sop=chosen_sop, file=dicom_file)
  @test isfile(dicom_file)
  println("Size of dicom file: $(filesize(dicom_file))")
end

@testset "Download series" begin
  series = tcia_series(collection="PDMR-Texture-Analysis", patient="172845-142-T-1259")
  seriesjs = tcia_series(collection="PDMR-Texture-Analysis", patient="172845-142-T-1259", format="json")
  tcia_download_series(series, joinpath(testdatadir, "testdf"))
  tcia_download_series(seriesjs, joinpath(testdatadir, "testjs"))
  tcia_download_series(series, joinpath(testdatadir, "testdf"); overwrite=false)
end


@testset "Utilities - remove_empty!()" begin
  dict_potentialy_empty_values = Dict(1 => "", 2 => "hello", 3 => "b", 4 => "", 5 => "ye")
  CancerImagingArchive.remove_empty!(dict_potentialy_empty_values)
  nonempty_keys = []
  for (key, value) in dict_potentialy_empty_values
    @test !isempty(value)
    push!(nonempty_keys, key)
  end
  @test sort(nonempty_keys) == [2, 3, 5]
end

@testset "Utilities - Data writer" begin
  tabular_data = tcia_collections()
  dataframe_to_csv(dataframe=tabular_data, file=csv_file)
  @test isfile(csv_file)
  println("Size of csv file: $(filesize(csv_file))")

  dict_array = tcia_collections(format="json")
  dictionary_to_json(dictionary=dict_array, file=json_file)
  @test isfile(json_file)
  println("Size of json file: $(filesize(json_file))")
end

if isdir(testdatadir)
  rm(testdatadir, recursive=true)
end
