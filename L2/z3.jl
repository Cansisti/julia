# Tomasz Beneś
# task 3, list 2

using LinearAlgebra

function matcond(n::Int, c::Float64)
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
	if n < 2
		error("size n should be > 1")
	end
	if c< 1.0
		error("condition number  c of a matrix  should be >= 1.0")
	end
	(U,S,V)=svd(rand(n,n))
	return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

function hilb(n::Int)
# Function generates the Hilbert matrix  A of size n,
#  A (i, j) = 1 / (i + j - 1)
# Inputs:
#	n: size of matrix A, n>=1
#
#
# Usage: hilb(10)
#
# Pawel Zielinski
	if n < 1
		error("size n should be >= 1")
	end
	return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end

# Hilbert
function hilb_test()
	println("------ hilb_test")

	for n = 10:20
		A = hilb(n)
		x = ones(Float64, n) # Wektor rozwiązań
		b = A*x
		
		x1 = A\b
		x2 = inv(A)*b

		println("--- matrix size:  ", n)
		println("--- error Gauss:  ", norm(x1-x)/norm(x))
		println("--- error invert: ", norm(x2-x)/norm(x))
		println()
	end
end

# Matcond
function matcond_test()
	println("------ matcond_test")
	
	ns = [5, 10, 20]
	cs = [1.0, 10.0, 10.0^3, 10.0^7, 10.0^12, 10.0^16]

	for n in ns # Ilość rozwiązań
		for c in cs # cond
			A = matcond(n, c)
			x = ones(Float64, n) # Wektor rozwiązań
			b = A*x

			x1 = A\b
			x2 = inv(A)*b

			println("--- size, cond:   ", n, ", ", c)
			println("--- error Gauss:  ", norm(x1-x)/norm(x))
			println("--- error invert: ", norm(x2-x)/norm(x))
			println()
		end
	end
end

hilb_test()
println()
matcond_test()