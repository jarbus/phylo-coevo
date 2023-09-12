export NG_Individual

struct NG_Individual{N} <: AbstractIndividual where N <: Int
    id::Id
    pid::Id
    genome::NTuple{N, Float64}
end
