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

"""
    psample(plower::Vector{Float64}, pupper::Vector{Float64})

Generate a probability distribution, uniformly at random, from the ambiguity set defined by the `pupper` and `plower` probabilities.
"""
function psample(plower::Vector{Float64}, pupper::Vector{Float64})
    n = length(plower)
    A = zeros(Float64, 2n+1, n)
    for i = 1:n
        A[2i - 1,i] = 1.0
        A[2i, i] = -1.0
    end
    A[end,:] = ones(n)
    bc = Array{Float64}(2n+1)
    for i = 1:n
        bc[2i - 1] = pupper[i]
        bc[2i] = -1.0 * plower[i]
    end
    bc[end] = 1.0
    d = vcat(fill("<=", 2n),"=")
    nsample = 1
    rout = R"""
    library(hitandrun)
    constr <- list(constr = $A, rhs = $bc, dir = $d)
    samples <- hitandrun(constr, n.samples = $nsample, thin = ($n) ^ 3)
    """
    p = reshape(rcopy(rout), n)
end

psample(pint::PInterval) = psample(pint.plower, pint.pupper)
