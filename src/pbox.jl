"""
    PBox <: SimpleProbabilitySet

Probability box defined by lower and upper distributions.
"""
struct PBox <: SimpleProbabilitySet
    dlower::Union{Bernoulli, DiscreteUniform, Categorical}
    dupper::Union{Bernoulli, DiscreteUniform, Categorical}
end

"""
    PBox(d::Distribution)

Degenerate probability box of only disribution 'd'
"""
PBox(d::Union{Bernoulli, DiscreteUniform, Categorical}) = PBox(d,d) # degenerate PBox

"""
    PBox()

Default probability box of Bernoulli(0.4) and Bernoulli(0.6)
"""
PBox() = PBox(Bernoulli(0.4), Bernoulli(0.6)) # default PBox

"""
    pdfs(pb::PBox)

Tuple of lower and upper pdfs
"""
pdfs(pb::PBox) = pdf.(pb.dlower, support(pb.dlower)), pdf.(pb.dupper, support(pb.dupper))

"""
    cdfs(pb::PBox)

Tuple of lower and upper cdfs
"""
cdfs(pb::PBox) = cdf.(pb.dlower, support(pb.dlower)), cdf.(pb.dupper, support(pb.dupper))

function pints(pb::PBox)
    cdflower, cdfupper = cdfs(pb)
    n = length(cdflower)
    plower = Array{Float64}(n)
    pupper = Array{Float64}(n)
    plower[1] = cdflower[1]
    pupper[1] = cdfupper[1]
    for i = 2:n
        plower[i] = max(cdflower[i] - cdfupper[i - 1], 0)
        pupper[i] = cdfupper[i] - cdflower[i - 1]
    end
    (plower, pupper)
end
