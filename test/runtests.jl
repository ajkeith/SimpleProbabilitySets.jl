using SimpleProbabilitySets
using Base.Test, Distributions

@testset "SimpleProbabilitySets" begin
    d = Categorical([0.1, 0.2, 0.7])
    d2 = Categorical([0.4, 0.4, 0.2])
    pb = PBox(d, d2)
    @test cdfs(pb)[2] == [0.4, 0.8, 1.0]
    @test pints(pb)[1] ≈ [0.1, 0.0, 0.2] atol = 1e-6

    pl = [0.1, 0.2, 0.7]
    pu = [0.4, 0.4, 0.2]
    uncsmall = 0.05
    unclarge = 0.4
    pi = PInterval(pl, pu)
    pi2 = PInterval(pl, uncsmall)
    pi3 = PInterval(pl, unclarge)
    @test pi.plower == [0.1, 0.2, 0.7]
    @test pi2.plower ≈ [0.05, 0.15, 0.65] atol = 1e-6
    @test pi3.pupper ≈ [0.5, 0.6, 1.0] atol = 1e-6
end
