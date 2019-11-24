# Tomasz Beneś

include("mfunctions.jl")
using .MFunctions

function f(x)
	sin(x) - (0.5 * x)^2
end

function pf(x)
	cos(x) - x
end

println(mbisekcji(f, 1.5, 2.0, 0.5e-5, 0.5e-5))

println(mstycznych(f, pf, 1.5, 0.5e-5, 0.5e-5, 10000))

println(msiecznych(f, 1.0, 2.0, 0.5e-5, 0.5e-5, 10000))