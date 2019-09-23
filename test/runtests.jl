using CancerImagingArchive
using Test

@testset "CancerImagingArchive.jl" begin
    tmp = Dict(1 => "", 2 => "hello", 3 => "b", 4 => "", 5 => "ye")
    CancerImagingArchive.remove_empty!(tmp)
    @test tmp == Dict(2 => "hello", 3 => "b", 5 => "ye")

    collections_csv = collections()
    collections_json = collections(format = "json")
    @test size(collections_csv)[1] == length(collections_json)
    @test collections_csv[1,1] == collections_json[1]["Collection"]
    @test collections_csv[end,1] ==  collections_json[end]["Collection"]

    @test length( modalities(collection = "TCGA-GBM", format = "json") ) >= 3
    @test size(modalities(bodypart = "BREAST"))[1] >= 6

    @test bodyparts(collection = "TCGA-BRCA")[1,1] == "BREAST"
    @test "BRAIN" in bodyparts(modality = "MR")[:,1]

    manu_list = manufacturers(modality="mr", bodypart="BRAIN").Manufacturer
    @test all( [manufacturer in manu_list for manufacturer in ["Philips", "Siemens", "GE", "Toshiba"]] )
    @test length(manufacturers(format="json")) >= 70

    @test length(patients(collection = "RIDER NEURO MRI", format = "json")) == 19
    patients_OT = patients_by_modality(collection = "ACRIN-FLT-Breast", modality = "OT", format = "json")
    @test patients_OT[1]["PatientID"] == "ACRIN-FLT-Breast_066"

    study = studies(collection = "RIDER PHANTOM PET-CT")
    @test length(study.PatientID) == 20
    series_ids = series(collection = "RIDER PHANTOM PET-CT", patient = study.PatientID[1]).SeriesInstanceUID
    @test length(series_ids) == study.SeriesCount[1]
    @test series_size(series = series_ids[1], format = "json")[1]["ObjectCount"] == 47

    single_sop = sop(series = series_ids[1])
    test_dicom = joinpath(@__DIR__, "test.dcm")
    single_image(series = series_ids[1], sop = single_sop.sop_instance_uid[1], file=test_dicom)
    @test isfile(test_dicom)
    @test filesize(test_dicom) == 38100

    test_zip = joinpath(@__DIR__, "test.zip")
    images(series = series_ids[1], file = test_zip)
    @test isfile(test_zip)
    @test filesize(test_zip) == 1294021

    @test length(newstudies(collection="TCGA-GBM", date="2015-01-01", format="json")) == 3
    @test isempty(newstudies(collection="TCGA-GBM", date="9999-01-01", format="json"))

    @test dataframe_to_csv(dataframe = study, file = "test.csv") == nothing
    @test dictionary_to_json(dictionary = patients_OT, file = "test.json") == nothing

    ## Broken for some reason
    # newpatients(collection="TCGA-GBM", date="1940-01-01")
end
