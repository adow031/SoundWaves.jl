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
