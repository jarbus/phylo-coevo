using Dates
using LRUCache

export AbstractIndividual, AbstractInteractionDistanceMetric,
       AbstractFitnessEstimator, AbstractMatchupSampler,
       NG_Individual, AsexualPhylogeneticTree, InteractionCache,
       Population, Experiment, Id, InteractionOutcome, Distance

abstract type AbstractIndividual end
abstract type AbstractInteractionDistanceMetric end
abstract type AbstractFitnessEstimator end
abstract type AbstractMatchupSampler end
abstract type AbstractSelectionMethod end
abstract type AbstractPhylogeneticTree end


Id = Int32
InteractionOutcome = Float32
Distance = Float32

struct NG_Individual{N} <: AbstractIndividual where N <: Int
    id::Id
    pid::Id
    genome::NTuple{N, Float64}
end

mutable struct AsexualPhylogeneticTree
    cur_idx::Id
    tree::Vector{Id}
    dist_cache::LRU{Tuple{Id,Id}, Distance} where N
    AsexualPhylogeneticTree() = new(Id(0), Vector{Id}(), LRU{Tuple{Id,Id}, Distance}(maxsize=1000))
end

struct AdditiveInteractionDistanceMetric <: AbstractInteractionDistanceMetric end

InteractionCache = LRU{NTuple{N,Id}, InteractionOutcome} where N

struct Population{T}
    individuals::Vector{T}
    phylogeny::AsexualPhylogeneticTree
end

struct Experiment{IndType,NumPops}
    name::String
    description::String
    datetime::DateTime
    populations::Vector{Population{IndType}}
    interaction_cache::InteractionCache{NumPops}
end
