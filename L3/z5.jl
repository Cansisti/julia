# Tomasz Beneś

include("mfunctions.jl")
using .MFunctions

function f(x)
	return 3*x-MathConstants.e^x
end

println(mbisekcji(f, 0.0, 1.0, 1e-4, 1e-4))
println(mbisekcji(f, 1.0, 2.0, 1e-4, 1e-4))