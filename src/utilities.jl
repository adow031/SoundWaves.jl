function playSound(y)
    return wavplay(y, fs)
end

function addSound!(music::Vector{Float64}, sound::Vector{Float64}, time::Real)
    first = floor(Int, float(time) * fs)
    if first + length(sound) - 1 > length(music)
        append!(music, zeros(first + length(sound) - length(music)))
    end
    for i in 1:length(sound)
        music[i+first-1] += sound[i]
    end
end

function playSong(notes, instrument, shift = 0)
    snd = Float64[]
    time = 0.25

    for n in notes
        addSound!(snd, makeNote(n[1] + shift, n[2] - 1, instrument), time)
        if length(n) == 2
            time += 60 / tempo * 2.0^(n[2] - 1)
        else
            time += 60 / tempo * 2.0^(n[2] - 1) * n[3]
        end
    end

    playSound(snd)
    return wavwrite(snd, "example.wav", Fs = fs)
end

function readSound(file::String)
    y, fs = wavread(joinpath(@__DIR__, file))
    return y[:, 1]
end

function writeSound(file::String)
    return wavwrite(music, "cullen.wav", Fs = fs)
end

function setHz(fs::Int)
    return env["fs"] = fs
end

function getHz()
    return env["fs"]
end
