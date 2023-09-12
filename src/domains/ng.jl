export NG_Individual, evaluate
import Base: rand

struct NG_Individual{N} <: AbstractIndividual where N <: Int
    id::Id
    pid::Id
    genome::NTuple{N, Float64}
end

function NG_Individual{N}(id::Id, pid::Id) where N
    genome = tuple(rand(N)...)
    NG_Individual{N}(id, pid, genome)
end


function compare_on_one(ind1::NG_Individual, ind2::NG_Individual)
    """Multi-dimensional evaluation function from The Numbers Game [1].
    Compares two individuals on the genome dimension of greatest difference.
    
    Returns:
        1 if ind1 is greater, 0 if ind2 is greater/equal on the dimension of greatest difference.

    [1] Watson, Richard A., and Jordan B. Pollack. “Coevolutionary Dynamics in a Minimal Substrate.” Proceedings of the 3rd Annual Conference on Genetic and Evolutionary Computation, Morgan Kaufmann Publishers Inc., 2001, pp. 702–09.
    """
    # find dimension of greatest difference
    max_diff = -1
    max_diff_dim = -1
    for i in eachindex(ind1.genome)
        diff = abs(ind1.genome[i] - ind2.genome[i])
        if diff > max_diff
            max_diff = diff
            max_diff_dim = i
        end
    end
    @assert max_diff_dim != -1
    if ind1.genome[max_diff_dim] > ind2.genome[max_diff_dim]
        return InteractionOutcome(1)
    else
        return InteractionOutcome(0)
    end
end

function evaluate(ind1::NG_Individual, ind2::NG_Individual)
    compare_on_one(ind1, ind2)
end
