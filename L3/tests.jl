include("mfunctions.jl")

using .MFunctions

# functions for tests

function parabola(x)
	return x^2 - 1
end

function pparabola(x)
	return 2*x
end

function x3mx2(x)
	return x^3-x^2
end

function px3mx2(x)
	return 3*x^2-2*x
end

# tests

function mbisekcji_test()
	println("--Running tests for mbisekcji")
	@assert mbisekcji(parabola, 10.0, 20.0, 0.0, 0.0) == (0, 0, 0, 1)
	@assert mbisekcji(parabola, -2.0, 0.0, 0.0, 0.0) == (-1.0, 0.0, 1, 0)
	@assert mbisekcji(parabola, 0.0, 2.0, 0.0, 0.0) == (1.0, 0.0, 1, 0)

	@assert mbisekcji(x3mx2, -0.2, 1.2, 0.0, 0.0) == (1.0, 0.0, 52, 0)
	@assert mbisekcji(x3mx2, -0.2, 0.6, 0.0, 0.0) != (0.0, 0.0, 2, 0) # metoda bisekcji nie znajdzie pierwiastka jeśli f nie zmienia znaku
	@assert mbisekcji(sin, pi/2, 3*pi/2, pi/100, pi/100) == (3.141592653589793, sin(pi), 1, 0)

	r, fr, it, err = mbisekcji(sin, pi/2, 7*pi/4, pi/10^7, 10^-7)
	@assert abs(r-pi) < pi/10^7
	@assert abs(fr) < 10^-7

	println("--Passed all")
end

function mstycznych_test()
	println("--Running tests for mstycznych")
	@assert mstycznych(parabola, pparabola, 2.0, 0.0, 0.0, 0) == (2.0, parabola(2.0), 1, 1)
	@assert mstycznych(parabola, pparabola, 2.0, 0.0, 0.0, 10) == (1.0, 0.0, 7, 0)
	@assert mstycznych(parabola, pparabola, -2.0, 0.0, 0.0, 10) == (-1.0, 0.0, 7, 0)

	@assert mstycznych(x3mx2, px3mx2, 1.5, 0.0, 0.0, 10) == (1.0, 0.0, 7, 0)
	
	r, fr, it, err = mstycznych(x3mx2, px3mx2, -0.2, 1e-100, 1e-100, 100)
	@assert abs(r) > 1e-100
	@assert abs(fr) > 1e-100
	@assert err == 1
	@assert it == 101

	r, fr, it, err = mstycznych(x3mx2, px3mx2, -0.2, 1e-100, 1e-100, 1000)
	@assert abs(r) < 1e-100 || abs(fr) < 1e-100
	@assert err == 0
	@assert it < 1000

	r, fr, it, err = mstycznych(sin, cos, 3.0, pi^-100, 1e-100, 1000)
	@assert abs(r-pi) == 0.0
	@assert abs(fr) > 1e-20
	@assert abs(fr) == sin(pi)

	println("--Passed all")
end

function msiecznych_test()
	println("--Running tests for msiecznych")

	@assert msiecznych(parabola, 0.6, 0.8, 0.0, 0.0, 10) == (1.0, 0.0, 6, 0)
	@assert msiecznych(parabola, -0.6, -0.8, 0.0, 0.0, 10) == (-1.0, 0.0, 6, 0)
	@assert msiecznych(parabola, 1.6, 1.8, 0.0, 0.0, 10) == (1.0, 0.0, 7, 0)

	r, fr, it, err = msiecznych(x3mx2, 0.6, 0.4, 1e-100, 1e-100, 200)
	@assert abs(r) < 1e-100 || abs(fr) < 1e-100
	@assert err == 0
	@assert it < 200

	r, fr, it, err = msiecznych(sin, 3.0, 3.1, pi^-100, 1e-100, 10)
	@assert abs(r-pi) == 0.0
	@assert abs(fr) > 1e-20
	@assert abs(fr) == sin(pi)

	println("--Passed all")
end

mbisekcji_test()
mstycznych_test()
msiecznych_test()