module PhyloCoEvo

include("structs.jl")
include("distances.jl")
include("selectors.jl")
include("estimators.jl")

include("domains/ng.jl")
include("population.jl")

include("experiment.jl")
end 
