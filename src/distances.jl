export RelativeDistance
function RelativeDistance(ind::Id,
                          rel::Id,
                          tree::AsexualPhylogeneticTree;
                          threshold::Union{Distance,Nothing}=nothing)
    """Returns the distance between ind and rel in the phylogenetic tree, or nothing if the distance exceeds the threshold.

    Relies on the following assumptions:
        1. IDs are assigned to individuals in ascending order, starting from 1

    This function climbs the tree until the most recent ancestor between ind1 and rel1 is found. We avoid overshooting the most recent ancestor by climbing from the lowest individual first
    """
    dist = Distance(0)
    while ind != rel
        ind == rel && return dist
        while ind > rel
            ind = tree.tree[ind] # assign ind to its parent
            dist += 1
            if threshold !== nothing && dist > threshold
                return nothing
            end
        end
        while rel > ind
            rel = tree.tree[rel] # assign rel to its parent
            dist += 1
            if threshold !== nothing && dist > threshold
                return nothing
            end
        end
    end
    if ind == 0 || rel == 0
        return nothing
    end
    return dist
end

function (::AdditiveInteractionDistanceMetric)()
end
