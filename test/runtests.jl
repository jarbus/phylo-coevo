using PhyloCoEvo
using Dates
using Test

function Experiment100()
    """Utility for creating a 100-population experiment"""
    Experiment{NG_Individual{3}, 2}(
        name="test",
        description="test",
        datetime=now(), 
        max_gens=100,
        pop_size=100,
        matchup_selector=AllVersusAllMatchupSelector(),
        interaction_distance_metric=AdditiveInteractionDistanceMetric(),
        fitness_estimator=PhylogeneticFitnessEstimator(),
        selection_method=FitnessProportionateSelection())
end


include("creation.jl")
include("distances.jl")
include("domains/ng.jl")
include("selectors.jl")
include("estimators.jl")

@testset "evaluate" begin
    exp = Experiment100()
    PhyloCoEvo.init_pops!(exp)
    matchups = exp.matchup_selector(exp)
    outcomes = PhyloCoEvo.evaluate!(exp, matchups)
    @test length(exp.interaction_cache) > 0
    @test length(outcomes) == length(matchups)
end

