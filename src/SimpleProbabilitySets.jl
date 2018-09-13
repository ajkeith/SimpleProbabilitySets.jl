module SimpleProbabilitySets

using Distributions

"""
    SimpleProbabilitySet

Abstract type for representing sets of probability distributions.
"""
abstract type SimpleProbabilitySet end

include("pbox.jl")
export
    PBox,
    pdfs,
    cdfs,
    pints

include("pinterval.jl")
export
    PInterval

end
