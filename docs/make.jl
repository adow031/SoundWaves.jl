using Documenter, SoundWaves

makedocs(
    sitename = "SoundWaves.jl",
    modules = [SoundWaves],
    clean = true,
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = ["SoundWaves" => "index.md", "API Reference" => "api.md"],
)

deploydocs(repo = "github.com/adow031/SoundWaves.jl.git", devurl = "docs")
