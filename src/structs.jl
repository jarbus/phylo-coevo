using Dates
using LRUCache

export AbstractIndividual, AbstractInteractionDistanceMetric,
       AbstractFitnessEstimator, AbstractMatchupSampler,
       AsexualPhylogeneticTree, InteractionCache,
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
MatchUp = NTuple{NumPops,Id} where NumPops
InteractionCache = LRU{MatchUp{NumPops}, InteractionOutcome} where NumPops

struct AdditiveInteractionDistanceMetric <: AbstractInteractionDistanceMetric end
struct AllVersusAllMatchupSampler <: AbstractMatchupSampler end

mutable struct AsexualPhylogeneticTree
    cur_idx::Id
    tree::Vector{Id}
    dist_cache::LRU{Tuple{Id,Id}, Distance} where N
    AsexualPhylogeneticTree() = new(Id(0), Vector{Id}(), LRU{Tuple{Id,Id}, Distance}(maxsize=1000))
end

struct Population{T}
    individuals::Dict{Id,T}
    phylogeny::AsexualPhylogeneticTree
end

@kwdef mutable struct Experiment{IndType,NumPops}
    name::String
    description::String
    datetime::DateTime
    cur_gen::Int=1
    max_gens::Int
    pop_size::Int
    populations::Vector{Population{IndType}}=Vector{Population{IndType}}()
    interaction_cache::InteractionCache{NumPops}=InteractionCache{NumPops}(maxsize=2000)
    matchup_sampler::AbstractMatchupSampler=AllVersusAllMatchupSampler()
end
