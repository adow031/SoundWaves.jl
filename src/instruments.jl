mutable struct Instrument
    amplitude::Real
    duration::Real
    ramps::Array{Tuple{Real,Symbol}}
    harmonics::Array{Tuple{Real,Real}}
    fade::Real
    wave::Function
end

function makeSound(frequency, amplitude, duration, wavetype)
    fs = getHz()

    t = 0.0:1/fs:prevfloat(float(duration))

    if wavetype[1] == :sine
        return sin.(2pi * frequency * t) * amplitude
    elseif wavetype[1] == :triangle
        return triangular.(frequency * t, wavetype[2]) * amplitude
    elseif wavetype[1] == :other
        return (
            -0.25 * sin.(3pi * frequency * t) +
            0.25 * sin.(pi * frequency * t) +
            sqrt(3) / 2 * cos.(pi * frequency * t)
        ) * amplitude
    elseif wavetype[1] == :square
        return square.(frequency * t)
    elseif wavetype[1] == :drum
        return drumbeat.(2pi * frequency * t) * amplitude
    elseif wavetype[1] == :silence
        return zeros(Float64, length(t))
    end
end

function drumbeat(x)
    return sin(2pi * 110 * exp(-x / pi / 110))
end

function square(x)
    if x % 1 <= 0.5
        return 1
    else
        return -1
    end
end

function triangular(x, p)
    y = x % 1
    if y <= p
        return 2 / p * y - 1
    else
        return 2 / (1 - p) * (1 - y) - 1
    end
end

function makeNote(note, dur, instrument::Instrument)
    tempo = getTempo()
    fs = getHz()

    default_duration = 60 / tempo * instrument.duration
    r1 = ramp(
        min(default_duration * 2.0^dur * 0.4, instrument.ramps[1][1]),
        instrument.ramps[1][2],
    )
    r2 = ramp(
        min(default_duration * 2.0^dur * 0.4, instrument.ramps[2][1]),
        instrument.ramps[2][2],
    )
    basefreq = 440
    freq = basefreq * 1.05946^note

    snd = instrument.wave(freq, instrument.amplitude, default_duration * 2.0^dur)

    for h in instrument.harmonics
        snd += instrument.wave(
            freq * h[1],
            instrument.amplitude * h[2],
            default_duration * 2.0^dur,
        )
    end
    snd = applyfadeout(snd, instrument.fade)
    snd = applyrampup(snd, r1)
    snd = applyrampdown(snd, r2)

    if length(snd) < fs * 60 / tempo * 2.0^dur
        snd = [
            snd
            zeros(ceil(Int, (fs * 60 / tempo * 2.0^ceil(dur) - length(snd)) / 2))
            zeros(floor(Int, (fs * 60 / tempo * 2.0^ceil(dur) - length(snd)) / 2))
        ]
    end

    return snd
end
