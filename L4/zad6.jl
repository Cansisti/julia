# Tomasz Beneś

include("funs.jl")

function c(x)
	return abs(x)
end

function d(x)
	return 1 / (1 + x^2)
end

using Plots

funs.rysujNnfx(c, -1.0, 1.0, 5)
savefig("6.a.5.png")

funs.rysujNnfx(c, -1.0, 1.0, 10)
savefig("6.a.10.png")

funs.rysujNnfx(c, -1.0, 1.0, 15)
savefig("6.a.15.png")

funs.rysujNnfx(d, -5.0, 5.0, 5)
savefig("6.b.5.png")

funs.rysujNnfx(d, -5.0, 5.0, 10)
savefig("6.b.10.png")

funs.rysujNnfx(d, -5.0, 5.0, 15)
savefig("6.b.15.png")