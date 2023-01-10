function ramp(tr, type = :cubic)
    fs = getHz()
    t = 0.0:1/fs:prevfloat(float(tr))

    if type == :linear
        return collect(t ./ prevfloat(float(tr)))
    elseif type == :quadratic
        a = 1 / (prevfloat(float(tr)))^2
        return a * t .^ 2
    elseif type == :cubic
        a = -2 / (prevfloat(float(tr)))^3
        b = 3 / (prevfloat(float(tr)))^2
        return a * t .^ 3 + b * t .^ 2
    else
        return ones(length(t))
    end
end

function applyrampup(y, r)
    for i in 1:min(length(r), length(y))
        y[i] *= r[i]
    end
    return y
end

function applyrampdown(y, r)
    for i in 1:min(length(r), length(y))
        y[end+1-i] *= r[i]
    end
    return y
end

function symmetric_ramp(y, r)
    temp = applyrampup(y, r)
    return applyrampdown(temp, r)
end

function applyfadeout(y, k)
    fs = getHz()
    f = 1:length(y)
    f = exp.(-k / fs * f)
    return y = y .* f
end
