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
