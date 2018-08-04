#VERSION >= v"0.4.0-dev+6521" && __precompile__()

"""
Julia wrappers around Let's be rational black76 calculator from Peter Jäckel
"""
module Black76

export normcdf, normpdf, px, impliedvol, ntv

const libpath = joinpath(dirname(@__FILE__), "..", "deps", "src", "liblbr")
"Cumulative standardized normal density"
normcdf(z::Real) = ccall((:norm_cdf, libpath), Float64, (Float64,), z)
"standard normal density"
normpdf(z::Real) = ccall((:norm_pdf, libpath), Float64, (Float64,), z)

"normalised black76 option time value"
function ntv(x::Real, w::Real)
    isnan(x) && return x
    isfinite(x) && return ccall((:normalised_black_call, libpath), Float64, (Float64, Float64), -abs(x), w)
    return 0
end

"Black76 European option value"
function px(fwd::Real, strike::Real, yf::Real, q::Real, iv::Real)
    ccall((:black, libpath), Float64, (Float64, Float64, Float64, Float64, Float64),
          fwd, strike, iv, yf, q)
end

"Black76 European option implied volatility"
function impliedvol(fwd::Real, strike::Real, yf::Real, q::Real, px::Real)
    ccall((:implied_volatility_from_a_transformed_rational_guess, libpath), Float64, 
          (Float64, Float64, Float64, Float64, Float64), px, fwd, strike, yf, q)
end

end # module Black76
