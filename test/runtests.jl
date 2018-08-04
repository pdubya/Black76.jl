using Black76
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

@testset "normcdf" begin
    z = normcdf(0.6)
    @test z > 0.5
end

@testset "normpdf" begin
    z = normcdf(0.6)
    @test z > 0.0
end

@testset "ntv" begin
    v = ntv(-0.6, 0.2)
    u = ntv( 0.6, 0.2)
    @test v == u  # ntv is symmetric in log-strike argument

    @test ntv(log(0), 0.2) == zero(Float64)  # no tv at infinite log-strike
end

@testset "black formulas" begin

    yf = 0.25
    df = exp(-0.08*yf)
    v0 = df*px(60.0/df, 65.0, yf, 1., 0.3);
    @test v0 ≈ 2.1334 atol = 5e-5  # Haug sample value

    round_trip(v) = impliedvol(100., 100., 1., -1., px(100., 100., 1., -1., v))
    # 20 vol roundtrip
    vol = 0.2
    rt_vol = round_trip(vol)
    @test rt_vol ≈ vol atol = 1e-14

    # 200 vol roundtrip
    vol = 2.
    rt_vol = round_trip(vol)
    @test rt_vol ≈ vol atol = 1e-14

    # 500 vol roundtrip
    vol = 5.
    rt_vol = round_trip(vol)
    @test rt_vol ≈ vol atol = 1e-14

    # zero premium returns zero vol
    @test impliedvol(100., 105., 1., 1., 0.) == zero(Float64)
end

