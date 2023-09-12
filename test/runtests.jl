using PhyloCoEvo
using Dates
using Test

@testset "Constructors" begin
    id = Int32(1)
    pid = Int32(1)
    ng_ind  = NG_Individual(id, pid, (1.0, 2.0, 3.0))
    pt      = AsexualPhylogeneticTree()
    i_cache = InteractionCache{2}(maxsize=2000)
    inds    = Dict(id=>ng_ind)
    pop     = Population{NG_Individual{3}}(inds, pt)
    pops    = [pop, pop]

    exp = Experiment{NG_Individual{3}, 2}(
            name="test",
            description="test",
            datetime=now(), 
            max_gens=100,
            populations=pops,
            interaction_cache=i_cache)
end

@testset "Distances" begin
    @testset "RelativeDistance" begin
        pt = AsexualPhylogeneticTree()
        pt.tree = [0, 1, 1, 2, 2, 3, 3, 4, 4, 5]
        #            1
        #        2       3
        #      4   5    6 7
        #     8 9 10
        @test RelativeDistance(Id(1), Id(1), pt) == 0
        @test RelativeDistance(Id(1), Id(2), pt) == 1
        @test RelativeDistance(Id(1), Id(2), pt, threshold=Distance(0)) === nothing
        @test RelativeDistance(Id(2), Id(3), pt) == 2
        @test RelativeDistance(Id(4), Id(5), pt) == 2
        @test RelativeDistance(Id(4), Id(6), pt) == 4
        @test RelativeDistance(Id(10),Id(1), pt) == 3
        @test RelativeDistance(Id(10),Id(7), pt) == 5
        @test RelativeDistance(Id(10),Id(7), pt, threshold=Distance(2)) === nothing
    end
end
