function DualInteractionMatrix(ex::Experiment)
    ids_1 = Dict(k => i for (i, k) in enumerate(keys(ex.populations[1].individuals)))
    ids_2 = Dict(k => i for (i, k) in enumerate(keys(ex.populations[2].individuals)))
    evaluated = zeros(Float32, length(ids_1), length(ids_2))
    predicted = zeros(Float32, length(ids_1), length(ids_2))
    is_prediction = falses(length(ids_1), length(ids_2))
    DualInteractionMatrix(ids_1, ids_2, evaluated, predicted, is_prediction)
end
function assign_outcomes!(dim::DualInteractionMatrix, matchups::Vector{MatchUp}, outcomes::Vector{InteractionOutcome})
    for (matchup, outcome) in zip(matchups, outcomes)
        r,c = dim.id_map_row[matchup[1]], dim.id_map_col[matchup[2]]
        dim.evaluated[r,c] = outcome
        dim.is_prediction[r,c] = false
        dim.predicted[r,c] = outcome
    end
end
function (::PhylogeneticFitnessEstimator)(ex::Experiment, matchups::Vector{MatchUp}, outcomes::Vector{InteractionOutcome})
    dim = DualInteractionMatrix(ex)
    # Assign all the matchup outcomes
    assign_outcomes!(dim, matchups, outcomes)
end
