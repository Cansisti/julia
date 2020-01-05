# Tomasz Beneś

module blocksys
using SparseArrays, LinearAlgebra
export read_matrix, read_vector, write_solution, find_right_side, gaussian_elimination, gaussian_elimination_with_pivots

# Read matrix from given file
# Returns:
#	A - sparsed block matrix
#	n - matrix size
#	l - block size
function read_matrix(file_path::String)
	open(file_path) do file
		line = split(readline(file))
		n = parse(Int64, line[1])
		l = parse(Int64, line[2])
		elements_count = n*l + 3*(n-l)
		J = Array{Int64}(undef, elements_count)
		I = Array{Int64}(undef, elements_count)
		V = Array{Float64}(undef, elements_count)
		i = 1
		while !eof(file)
			ln = split(readline(file))
			J[i] = parse(Int64, ln[1])
			I[i] = parse(Int64, ln[2])
			V[i] = parse(Float64, ln[3])
			i += 1
		end
		A = sparse(I, J, V)
		return (A, n, l)
	end
end

# Read vector from given file
# Returns:
#	b - the vector
function read_vector(file_path::String)
	open(file_path) do file
		n = parse(Int64, readline(file))
		b = Array{Float64}(undef, n)
		i = 0
		while !eof(file)
			i += 1
			b[i] = parse(Float64, readline(file))
		end
		return b
	end
end

# Write solution to file
# Arguments:
#	x - the solution
#	n - solution's size
#	write_error - if true, file will include calculated error (assuming x = ones)
# Returns: nothing
function write_solution(file_path::String, x::Array{Float64}, n::Int64, write_error::Bool)
	open(file_path, "w") do file
		if (write_error)
			relative_error = norm(ones(n) - x) / norm(x)
			println(file, relative_error)
		end
		for i in 1 : n
			println(file, x[i])
		end
	end
end

# Calculate right side vector of block matrix, assuming x = ones
# Arguments:
#	A - the matrix
#	b - matrix's size
#	l - block size
# Returns:
#	b - the right side
function find_right_side(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	b = zeros(Float64, n)
	for i in 1 : n
		from_col = convert(Int64, max(l * floor((i-1) / l) - 1, 1))
		last_col = convert(Int64, min(l + l * floor((i-1) / l), n))
		for j in from_col : last_col
			b[i] += A[j, i]
		end
		if (i + l <= n)
			b[i] += A[i + l, i]
		end
	end
	return b
end

# Solve the system of linear equations given as block matrix by Gauss elimination
# Arguments:
#	A - the matrix
#	n - matrix's size
#	l - block size
#	b - right side vector
# Returns:
#	x - solution vector
function gaussian_elimination(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	for k in 1 : n-1
		# Ostatni wiersz, w którym wystąpi coś innego niż 0 w kolumnie k
		last_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		# Ostatnia niezerowa kolumna ostatniego wiersza
		last_col = convert(Int64, min(k + l, n))
		for i in k + 1 : last_row
			if abs(A[k,k]) < eps(Float64)
				error("Value on diagonal equals 0")
			end
			# Ilukrotnie odejmujemy k-ty wiersz
			z = A[k, i] / A[k, k]
			A[k, i] = 0
			for j in k + 1 : last_col
				A[j, i] = A[j, i] - z * A[j, k]
			end
			b[i] = b[i] - z * b[k]
		end
	end
	x = Array{Float64}(undef, n)
	for i in n : -1 : 1
		total = 0.0
		# Ostatnia kolumna, w której występuje wartość inna niż 0 w i-tym wierszu
		last_col = min(n, i + l)
		for j in i + 1 : last_col
			total += A[j, i] * x[j]
		end
		x[i] = (b[i] - total) / A[i, i]
	end
	return x
end

# Solve the system of linear equations given as block matrix by Gauss elimination with pivots
# Arguments:
#	A - the matrix
#	n - matrix's size
#	l - block size
#	b - right side vector
# Returns:
#	x - solution vector
function gaussian_elimination_with_pivots(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	# Wektor permutacji wierszy
	p = collect(1:n)
	for k in 1:n - 1
		# Ostatni wiersz, w którym wystąpi coś innego niż 0 w kolumnie k
		last_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		# Ostatnia niezerowa kolumna ostatniego wiersza
		last_col = convert(Int64, min(2*l + l * floor((k+1) / l), n))
		for i in k + 1 : last_row
			# Indeks wiersza z największą wartością (elementem głównym)
			max_row = k
			# Największa wartość
			max = abs(A[k,p[k]])
			for x in i : last_row
				if (abs(A[k,p[x]]) > max)
					max_row = x;
					max = abs(A[k,p[x]])
				end
			end
			if (abs(max) < eps(Float64))
				error("Singular matrix")
			end
			# Przestawienie wierszy w wektorze permutacji
			p[k], p[max_row] = p[max_row], p[k]
			# Ilukrotnie odejmujemy k-ty wiersz
			z = A[k,p[i]] / A[k,p[k]]
			A[k,p[i]] = 0
			for j in k + 1 : last_col
				A[j,p[i]] = A[j,p[i]] - z * A[j,p[k]]
			end
			b[p[i]] = b[p[i]] - z * b[p[k]]
		end
	end
	x = Array{Float64}(n)
	for i in n : -1 : 1
		total = 0.0
		# Ostatnia kolumna, w której występuje wartość inna niż 0 w i-tym wierszu
		last_col = convert(Int64, min(2*l + l*floor((p[i]+1)/l), n))
		for j in i + 1 : last_col
			total += A[j,p[i]] * x[j]
		end
		x[i] = (b[p[i]] - total) / A[i, p[i]]
	end
	return x
end

end