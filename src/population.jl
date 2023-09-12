export add_individual!, rm_individual!, init_population, Population

function Population{T}() where T
    Population{T}(Dict{Id,T}(), AsexualPhylogeneticTree())
end

function init_population(T::Type{<:AbstractIndividual}, num_inds::Int)
    pop = Population{T}()
    for i in 1:num_inds
        add_individual!(pop)
    end
    pop
end

function add_individual!(pop::Population{T}, pid::Id=Id(0)) where T <: AbstractIndividual
    # Create a new ind with the next id
    pop.phylogeny.cur_idx += 1
    id = Id(pop.phylogeny.cur_idx)
    ng_ind = T(id, pid)
    # Add the new ind to the phylogenetic tree
    push!(pop.phylogeny.tree, pid)
    @assert length(pop.phylogeny.tree) == id
    # Add the new ind to the population
    pop.individuals[id] = ng_ind
    return ng_ind
end

function rm_individual!(pop::Population{T}, id::Id) where T <: AbstractIndividual
    # Remove the individual from the population
    delete!(pop.individuals, id)
end
