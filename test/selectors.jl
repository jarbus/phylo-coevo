@testset "AllVsAll" begin
    exp = Experiment100()
    PhyloCoEvo.init_pops!(exp)
    matchups = exp.matchup_selector(exp)
    @test length(matchups) == 10000
    @test typeof(matchups) == Vector{PhyloCoEvo.MatchUp}
end
