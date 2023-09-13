using Dates
using LRUCache

export AbstractIndividual, AbstractInteractionDistanceMetric,
       AbstractFitnessEstimator, AbstractMatchupSelector,
       AsexualPhylogeneticTree, InteractionCache, AdditiveInteractionDistanceMetric,
       Population, Experiment, Id, InteractionOutcome, Distance,
       PhylogeneticFitnessEstimator, AdditiveInteractionDistanceMetric,
       FitnessProportionateSelection, LexicaseSelection, DualInteractionMatrix

abstract type AbstractIndividual end
abstract type AbstractInteractionDistanceMetric end
abstract type AbstractFitnessEstimator end
abstract type AbstractMatchupSelector end
abstract type AbstractSelectionMethod end
abstract type AbstractPhylogeneticTree end

Id = Int32
InteractionOutcome = Float32
Distance = Float32
MatchUp = NTuple{NumPops,Id} where NumPops
InteractionCache = LRU{MatchUp{NumPops}, InteractionOutcome} where NumPops

struct AdditiveInteractionDistanceMetric <: AbstractInteractionDistanceMetric end
struct AllVersusAllMatchupSelector <: AbstractMatchupSelector end
struct PhylogeneticFitnessEstimator <: AbstractFitnessEstimator end
struct FitnessProportionateSelection <: AbstractSelectionMethod end
struct LexicaseSelection <: AbstractSelectionMethod end

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
    matchup_selector::AbstractMatchupSelector
    interaction_distance_metric::AbstractInteractionDistanceMetric
    fitness_estimator::AbstractFitnessEstimator
    selection_method::AbstractSelectionMethod
end
