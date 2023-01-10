module SoundWaves

using WAV

env["fs"] = 44100
env["tempo"] = 100

include("fades.jl")
include("instruments.jl")
include("utilities.jl")

export playSong
end
