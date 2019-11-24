# Tomasz Beneś

include("mfunctions.jl")
using .MFunctions

function f(x)
	return (MathConstants.e^(1-x))-1
end

function pf(x)
	return -MathConstants.e^(1-x)
end

function g(x) # f2
	return x*(MathConstants.e^(-x))
end

function pg(x)
	return (-MathConstants.e^(-x))*(x-1)
end

println()
println("f bisekcji")
println(mbisekcji(f, 0.5, 2.0, 1e-5, 1e-5))
println(mbisekcji(f, -500.0, 500.0, 1e-5, 1e-5))

println()
println("f stycznych")
println(mstycznych(f, pf, 0.0, 1e-5, 1e-5, 1000000))
println(mstycznych(f, pf, -10.0, 1e-5, 1e-5, 1000000))
println(mstycznych(f, pf, 10.0, 1e-5, 1e-5, 1000000))

println()
println("f siecznych")
println(msiecznych(f, 0.0, 2.0, 1e-5, 1e-5, 1000000))
println(msiecznych(f, -10.0, 10.0, 1e-5, 1e-5, 1000000))

println()
println("g bisekcji")
println(mbisekcji(g, -2.0, 3.0, 1e-5, 1e-5))
println(mbisekcji(g, -20.0, 30.0, 1e-5, 1e-5))

println()
println("g stycznych")
println(mstycznych(g, pg, -1.0, 1e-5, 1e-5, 1000000))
println(mstycznych(g, pg, 1.0, 1e-5, 1e-5, 1000000))
println(mstycznych(g, pg, 1.5, 1e-5, 1e-5, 1000000))

println()
println("g siecznych")
println(msiecznych(g, -1.0, 1.0, 1e-5, 1e-5, 1000000))
println(msiecznych(g, -1.0, 2.0, 1e-5, 1e-5, 1000000))