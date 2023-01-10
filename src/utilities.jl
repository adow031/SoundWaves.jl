function playSound(y)
    fs = getHz()
    return wavplay(y, fs)
end

function addSound!(music::Vector{Float64}, sound::Vector{Float64}, time::Real)
    fs = getHz()
    first = floor(Int, float(time) * fs)
    if first + length(sound) - 1 > length(music)
        append!(music, zeros(first + length(sound) - length(music)))
    end
    for i in 1:length(sound)
        music[i+first-1] += sound[i]
    end
end

function playSong(notes::Vector{<:Tuple{Int,Real}}, instrument, shift = 0)
    tempo = getTempo()

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
    return snd
end

function playSong(notes::Vector{<:Tuple{Symbol,Vararg{Real}}}, instrument, shift = 0)
    tempo = getTempo()

    snd = Float64[]
    time = 0.25

    for n in notes
        addSound!(snd, makeNote(getNote(n[1]) + shift, n[2] - 1, instrument), time)
        if length(n) == 2
            time += 60 / tempo * 2.0^(n[2] - 1)
        else
            time += 60 / tempo * 2.0^(n[2] - 1) * n[3]
        end
    end

    playSound(snd)
    return snd
end

function readSound(file::String)
    y, fs = wavread(joinpath(@__DIR__, file))
    return y[:, 1]
end

function writeSound(file::String)
    return wavwrite(music, file, Fs = fs)
end

function setHz(fs::Int)
    return ENV["fs"] = fs
end

function setTempo(tempo::Int)
    return ENV["tempo"] = tempo
end

function getHz()
    return parse(Int, get(ENV, "fs", "44100"))
end

function getTempo()
    return parse(Int, get(ENV, "tempo", "100"))
end

function mixNotes(
    notes::Vector{Symbol},
    durations::Vector,
    deltas::Vector{<:Real} = ones(length(notes)),
)
    result = Tuple{Symbol,Vararg{Real}}[]
    for i in eachindex(notes)
        if typeof(durations[i]) <: Real
            push!(result, (notes[i], durations[i]))
        elseif typeof(durations[i]) <: Tuple{<:Real,<:Real}
            push!(result, (notes[i], durations[i][1], durations[i][2]))
        else
            error("Invalid duration")
        end
    end
    return result
end

function getNote(note::Symbol)
    note = string(note)
    if length(note) ∉ [2, 3]
        error("Note must be either 2 or 3 characters")
    end

    value = 0
    if note[1] ∈ ['C', 'D', 'E']
        value = convert(Int, note[1]) * 2 - 134
    elseif note[1] ∈ ['F', 'G']
        value = convert(Int, note[1]) * 2 - 135
    elseif note[1] ∈ ['A', 'B']
        value = convert(Int, note[1]) * 2 - 121
    else
        error("Invalid note letter")
    end

    try
        oct = parse(Int, note[2]) - 4
        value += oct * 12
    catch
        error("Invalid octave")
    end

    if length(note) == 3
        if note[3] == ♯
            value += 1
        elseif note[3] == ♭
            value -= 1
        else
            error("Invalid 3rd character in note")
        end
    end
    return value
end
