using SoundWaves

include("instruments.jl")

song = [
    mixNotes([:G4, :A4, :B4, :G4], [1, 1, 1, 1], [1, 1, 1, 1.1])
    mixNotes([:G4, :A4, :B4, :G4], [1, 1, 1, 1], [1, 1, 1, 1.1])
    mixNotes([:B4, :C5, :D5], [1, 1, 2], [1, 1, 1.1])
    mixNotes([:B4, :C5, :D5], [1, 1, 2], [1, 1, 1.1])
    mixNotes([:D5, :E5, :D5, :C5, :B4, :G4], [0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1.2])
    mixNotes([:D5, :E5, :D5, :C5, :B4, :G4], [0, 0, 0, 0, 1, 1], [1, 1, 1, 1, 1, 1.2])
    mixNotes([:G4, :D4, :G4], [1.2, 1.3, 2])
    mixNotes([:G4, :D4, :G4], [1.2, 1.3, 3])
]

playSong(song, piano)
playSong(song, violin)
playSong(song, cello)
playSong(song, recorder)
