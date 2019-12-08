# Tomasz Beneś

include("funs.jl")

function a(x)
	return MathConstants.e^x
end

function b(x)
	return (x^2)*sin(x)
end

using Plots

funs.rysujNnfx(a, 0.0, 1.0, 5)
savefig("5.a.5.png")

funs.rysujNnfx(a, 0.0, 1.0, 10)
savefig("5.a.10.png")

funs.rysujNnfx(a, 0.0, 1.0, 15)
savefig("5.a.15.png")

funs.rysujNnfx(b, -1.0, 1.0, 5)
savefig("5.b.5.png")

funs.rysujNnfx(b, -1.0, 1.0, 10)
savefig("5.b.10.png")

funs.rysujNnfx(b, -1.0, 1.0, 15)
savefig("5.b.15.png")