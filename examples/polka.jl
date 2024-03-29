using SoundWaves

include("instruments.jl")

setTempo(60)

notes = [
    :D4,
    :C4,
    :B3,
    :D4,
    :G4,
    :B4,
    :D4,
    :G4,
    :B4,
    :D5,
    :B4,
    :B4,
    :B4,
    :B4,
    :D5,
    :B4,
    :B4,
    :D5,
    :B4,
    :B4,
    :D5,
    :D5,
    :C5,
    :A4,
    :F4,
    :D4,
    :D4,
    :E4,
    :D4,
    :C4,
    :D4,
    :F4,
    :A4,
    :D4,
    :F4,
    :A4,
    :C5,
    :F5,
    :F5,
    :F5,
    :E5,
    :C5,
]

song = mixNotes(
    notes,
    [
        -ones(10)
        [
            0,
            0,
            0,
            0,
            -1,
            -1,
            0,
            -1,
            -1,
            0,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            0,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            -1,
            0,
            0,
            0,
            -1,
            -1,
        ]
    ],
)

playSong(song, violin)
