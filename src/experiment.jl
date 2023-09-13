function evaluate!(ex::Experiment, matchup::MatchUp)
    get!(ex.interaction_cache, matchup) do
        inds = [ex.populations[i].individuals[matchup[i]] for i in eachindex(matchup)]
        outcome = evaluate(inds...)
        ex.interaction_cache[matchup] = outcome
        outcome
    end
end
function evaluate!(ex::Experiment, matchups::Vector{MatchUp})
    for matchup in matchups
        evaluate!(ex, matchup)
    end
end

function run_generation!(ex::Experiment)
    # Choose matchups
    matchups = ex.matchup_selector(ex)
    # Evaluate
    evaluate!(ex, matchups)
    # Estimate remaining interactions
    # Select
    # Reproduce
    # Record
    # Return
end

function init_pops!(ex::Experiment{IndType,NumPops}) where {IndType, NumPops}
    @assert length(ex.populations) == 0
    for _ in 1:NumPops
        push!(ex.populations, init_population(IndType, ex.pop_size))
    end
    @assert length(ex.populations) == NumPops
    for pop in ex.populations
        @assert length(pop.individuals) == ex.pop_size
    end
end

function run!(ex::Experiment{IndType,NumPops}) where {IndType, NumPops}
    # Initialize populations
    init_pops!(ex)
    for _ in ex.cur_gen:ex.max_gens
        run_generation!(ex)
    end
end
