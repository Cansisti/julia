# Tomasz Beneś

module MFunctions

export mbisekcji, mstycznych, msiecznych

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
			break
		end
	end
	return x, f(x), it, 0
end

function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)

	fx0 = f(x0)
	fx1 = f(x1)

	it = 0
	while abs(fx1) > epsilon
		it += 1
		if it > maxit
			return x0, fx0, it, 1 # error maxit
		end

		x1, x0 = x1-(x1-x0)/(fx1-fx0)*fx1, x1

		fx0 = fx1
		fx1 = f(x1)
		
		if abs(x0-x1) <= delta
			break
		end
	end
	return x1, fx1, it, 0
end

end