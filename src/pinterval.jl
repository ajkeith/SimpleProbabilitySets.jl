"""
    PInterval <: SimpleProbabilitySet

Credal set of categorical distributions defined by lower and upper probabilities.
"""
struct PInterval <: SimpleProbabilitySet
    plower::Vector{Float64}
    pupper::Vector{Float64}
end

"""
    PInterval(p::Vector{Float64}, uncsize::Float64)

Probability intervals centered on 'p' of width ± 'uncsize' (with saturated bounds)
"""
function PInterval(p::Vector{Float64}, uncsize::Float64)
    pl = zeros(length(p))
    pu = ones(length(p))
    for (i, pi) in enumerate(p)
        pl[i] = max(0.0, pi - uncsize)
        pu[i] = min(1.0, pi + uncsize)
    end
    PInterval(pl, pu)
end

"""
    PInterval(p::Vector{Float64})

Degenerate probability interval of only pmf 'p'
"""
PInterval(p::Vector{Float64}) = PInterval(p,p) # degenerate PInterval

"""
    PInterval()

Default probability interval of p1 ∈ [0.2, 0.3], p2 ∈ [0.7, 0.8]
"""
PInterval() = PInterval([0.2, 0.7], [0.3, 0.8]) # default PInterval
