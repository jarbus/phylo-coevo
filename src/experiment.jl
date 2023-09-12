function choose_interactions(ex::Experiment)
end
function evaluate!(ex::Experiment, matchup::MatchUp)
    get!(ex.interaction_cache, matchup) do
        inds = [ex.populations[i].individuals[matchup[i]] for i in eachindex(matchup)]
        evaluate!(inds...)
    end
end
function evaluate!(ex::Experiment, matchups::Vector{MatchUp})
    for matchup in matchups
        evaluate!(ex, matchup)
    end
end

function run_generation!(ex::Experiment)
    # Choose matchups
    matchups = choose_interactions(ex)
    # Evaluate
    evaluate!(ex, matchups)
    # Estimate
    # Select
    # Reproduce
    # Record
    # Return
end

function run!(ex::Experiment)
    for _ in ex.cur_gen:ex.max_gens
        run_generation!(ex)
    end
end
