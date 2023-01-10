module SoundWaves

using WAV

include("fades.jl")
include("instruments.jl")
include("utilities.jl")

export playSong, setHz, setTempo, Instrument, mixNotes, makeSound
end
