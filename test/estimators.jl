@testset "DualInteractionMatrix" begin
    exp = Experiment100()
    PhyloCoEvo.init_pops!(exp)
    dim = DualInteractionMatrix(exp)
    @test length(dim.id_map_row) == 100
    @test length(dim.id_map_col) == 100
    @test size(dim.evaluated) == (100, 100)
    @test size(dim.predicted) == (100, 100)
    @test size(dim.is_prediction) == (100, 100)
    # check if the id map keys are the same as the individuals
    @test sort(collect(keys(dim.id_map_row))) ==
            sort(collect(keys(exp.populations[1].individuals)))
    @test sort(collect(keys(dim.id_map_row))) == collect(1:100)
end
