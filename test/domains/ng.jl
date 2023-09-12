@testset "Numbers Game" begin
    @testset "evaluate" begin
        id1 = Id(1)
        id2 = Id(2)
        ng1 = NG_Individual(id1, Id(0), (1.0, 2.0, 3.0))
        ng2 = NG_Individual(id2, Id(0), (1.0, 0.0, 3.0))
        @test evaluate(ng1, ng1) == 0
        @test evaluate(ng1, ng2) == 1
        @test evaluate(ng2, ng1) == 0
        @test evaluate(ng2, ng2) == 0
    end
    @testset "Experiment Evaluate" begin

    end
end
