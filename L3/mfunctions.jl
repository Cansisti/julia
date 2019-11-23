# Tomasz Beneś

# module MFunctions

# export mbisekcji, mstycznych, msiecznych, mbisekcji_test

function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
	fa = f(a)
	fb = f(b)

	if fa*fb > 0
		return 0, 0, 0, 1 # error
	end

	it = 0
	c = (a+b)/2
	fc = f(c)
	while b-a > delta
		it += 1
		
		if abs(fc) <= epsilon
			break
		end
		
		if fa*fc > 0
			a = c
			fa = fc
		else
			b = c
		end

		c = (a+b)/2
		fc = f(c)
	end
	return c, fc, it, 0
end

function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
	
	it = 0
	fx0 = f(x0)
	x = x0
	while abs(fx0) >= epsilon
		it += 1

		if it > maxit
			return x0, fx0, it, 1 # error maxit
		end

		x0 = x
		fx0 = f(x0)
		pfx0 = pf(x0)

		if pfx0 == 0.0
			return x0, fx0, it, 2 # pf close to 0
		end

		x = x0 - fx0/pfx0

		if abs(x-x0) <= delta
			return x, f(x), it, 0
		end
	end
	return x, f(x), it, 0
end

function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
	
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

# end

mbisekcji_test()
mstycznych_test()