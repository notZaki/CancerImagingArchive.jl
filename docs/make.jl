push!(LOAD_PATH,"../src/")
using Documenter, CancerImagingArchive

makedocs(;
    modules=[CancerImagingArchive],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    pages=[
        "Introduction" => "index.md",
        "Guide" => Any[
            "Formats" => "guide/formats.md",
            "Queries" => "guide/queries.md",
            "Data Download" => "guide/downloading.md"
        ],
        "Functions" => "functions.md"
    ],
    repo="https://github.com/notZaki/CancerImagingArchive.jl/blob/{commit}{path}#L{line}",
    sitename="CancerImagingArchive.jl"
)

deploydocs(;
    repo="github.com/notZaki/CancerImagingArchive.jl",
)
