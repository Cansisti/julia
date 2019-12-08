# Tomasz Beneś

module funs 

using Plots

export ilorazyRoznicowe, warNewton, normalna, rysujNnfx

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
	fx = copy(f)
	for i = 2:length(x)
		for j = length(x):-1:i
			fx[j] = (fx[j] - fx[j-1]) / (x[j] - x[j+1-i])
		end
	end
	return fx
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
	nt = fx[length(fx)]
	for k = length(fx)-1:-1:1
		nt = fx[k] + (t - x[k])*nt
	end
	return nt
end

function normalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(x)
    a = Array{Float64}(undef, n)
    poly = zeros(n + 1, n + 1)
    poly[1,1] = 1
    for i in 1:n - 1
        poly[i + 1, 1] = 1
        poly[i + 1, 2:i + 1] = poly[i, 2:i + 1] - x[i] * poly[i, 1:i]
    end
    for i in n:-1:1
        a[i] = fx[i]
        for j in 1:n - i
            a[i] = a[i] + fx[i + j] * poly[i + j, j + 1]
        end
    end
    return a
end

function rysujNnfx(f, a::Float64, b::Float64, n::Int)
	if n <= 0
		error("Stopień mniejszy niż 0!")
	end
	h = (b-a)/n
	x = zeros(n)
	y = zeros(n)

	l = (2*n)^2

	for i = 1:n
		x[i] = a + (i-1)*h
		y[i] = f(x[i])
	end

	fx = ilorazyRoznicowe(x,y)

	interpolation = Array{Float64, 1}(undef, l)
	h = (b-a)/l
	Xi = Array{Float64}(undef, l)
	Y1 = Array{Float64}(undef, l)
	for i = 1:l
		Xi[i] = a + (i-1)*h
		Y1[i] = f(Xi[i])
		interpolation[i] = warNewton(x,fx,Xi[i])
		if interpolation[i] > 3
			interpolation[i] = 3
		end
		if interpolation[i] < -3
			interpolation[i] = -3
		end
	end

	plot(Xi, Y1)
	plot!(Xi, interpolation)
end

end
