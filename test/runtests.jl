using SimpleProbabilitySets
using Base.Test, Distributions

@testset "SimpleProbabilitySets" begin
    # Write your own tests here.
    d = Categorical([0.1, 0.2, 0.7])
    d2 = Categorical([0.4, 0.4, 0.2])
    pb = PBox(d, d2)
    @test cdfs(pb)[2] == [0.4, 0.8, 1.0]
    @test pinterval(pb)[1] ≈ [0.1, 0.0, 0.2] atol = 1e-6
end
