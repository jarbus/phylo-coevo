export AllVersusAllMatchupSampler
function (::AllVersusAllMatchupSampler)(ex::Experiment)
    @assert length(ex.populations) == 2
    matchups = Vector{MatchUp}()
    for id1 in keys(ex.populations[1].individuals)
        for id2 in keys(ex.populations[2].individuals)
            push!(matchups, (id1, id2))
        end
    end
    matchups
end
