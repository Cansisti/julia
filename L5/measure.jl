# Tomasz Beneś

include("blocksys.jl")

for i in 1000:1000:50000
	A, n, l = blocksys.read_matrix("L5/Output/A$i.txt")
	Ap = copy(A)
	b = blocksys.find_right_side(A, n, l)
	bp = copy(b)
	@time begin
		x = blocksys.gaussian_elimination(A, n, l, b)
	end
	@time begin
		xp = blocksys.gaussian_elimination_with_pivots(Ap, n, l, bp)
	end
	blocksys.write_solution("L5/Output/x$i.txt", x, n, true)
	blocksys.write_solution("L5/Output/xp$i.txt", xp, n, true)
end
