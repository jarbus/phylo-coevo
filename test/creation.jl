@testset "Creation" begin
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
    @testset "add/rm_individuals" begin
        # Add a parent and a child, then delete the parent
        ng = NG_Individual{3}(Id(1), Id(0))
        pop = Population{NG_Individual{3}}()
        add_individual!(pop)
        @test length(pop.individuals) == 1
        add_individual!(pop, Id(1))
        @test length(pop.individuals) == 2
        @test pop.individuals[Id(2)].pid == Id(1)
        @test pop.phylogeny.tree == [Id(0), Id(1)]
        rm_individual!(pop, Id(1))
        @test length(pop.individuals) == 1
        @test pop.phylogeny.tree == [Id(0), Id(1)]
    end
    @testset "init_population" begin
        pop = init_population(NG_Individual{3},10)
        @test length(pop.individuals) == 10
        @test pop.phylogeny.cur_idx == 10
        @test pop.phylogeny.tree == [Id(0), Id(0), Id(0), Id(0), Id(0), Id(0), Id(0), Id(0), Id(0), Id(0)]
    end
end


