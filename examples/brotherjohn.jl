using SoundWaves

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

piano = Instrument(
    0.5,
    0.7,
    [(0.05, :quadratic), (0.1, :cubic)],
    [(0.5, 0.2), (2, 0.2)],
    2,
    (x, y, z) -> makeSound(x, y, z, [:other]),
)
violin = Instrument(
    0.5,
    0.9,
    [(0.1, :cubic), (0.2, :cubic)],
    [(0.5, 0.5)],
    1.5,
    (x, y, z) -> makeSound(x, y, z, [:triangle, 0.9]),
)
recorder = Instrument(
    0.4,
    0.8,
    [(0.1, :cubic), (0.1, :cubic)],
    [(4, 0.05)],
    2,
    (x, y, z) -> makeSound(x, y, z, [:sine]),
)
cello = Instrument(
    0.2,
    0.8,
    [(0.05, :linear), (0.3, :cubic)],
    [(0.5, 1.5)],
    2,
    (x, y, z) -> makeSound(x, y, z, [:triangle, 0.75]),
)
drum = Instrument(
    0.7,
    0.7,
    [(0.1, :cubic), (0.1, :cubic)],
    [(4, 0.05)],
    0,
    (x, y, z) -> makeSound(x, y, z, [:drum, 100]),
)

playSong(song, piano)
playSong(song, violin)
playSong(song, cello)
playSong(song, recorder)
playSong(song, drum, -6)
