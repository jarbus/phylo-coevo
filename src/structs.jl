using Dates
using LRUCache

abstract type AbstractIndividual end
abstract type AbstractInteractionDistanceMetric end
abstract type AbstractFitnessEstimator end

Id = Int32
InteractionOutcome = Float32

struct NG_Individual{N} <: AbstractIndividual
    id::Id
    pid::Id
    genome::NTuple{N, Float64}
end

struct PhylogeneticTree
    cur_idx::Id
    tree::Array{Id, 1}
end

struct InteractionCache{N} 
    cache::LRUCache{NTuple{N,Id}, InteractionOutcome}
end

struct Population{T}
    individuals::Vector{T}
    phylogeny::PhylogeneticTree
end

struct Experiment{IndType,NumPops}
    name::String
    description::String
    datetime::DateTime
    populations::Vector{Population{IndType}}
    interaction_cache::InteractionCache{NumPops}

end
