@testset "AllVsAll" begin
    exp = Experiment{NG_Individual{3}, 2}(
            name="test",
            description="test",
            datetime=now(), 
            max_gens=100,
            pop_size=100,
            matchup_sampler=AllVersusAllMatchupSampler()
           )
    PhyloCoEvo.init_pops!(exp)
    matchups = exp.matchup_sampler(exp)
    @test length(matchups) == 10000
    @test typeof(matchups) == Vector{PhyloCoEvo.MatchUp}
    # PhyloCoEvo.evaluate!(exp)
end
