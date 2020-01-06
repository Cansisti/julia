# Tomasz Beneś

include("blocksys.jl")

A, n, l = blocksys.read_matrix("L5/Dane50000_1_1/A.txt")
A1 = copy(A)
b = blocksys.read_vector("L5/Dane50000_1_1/b.txt")
b1 = blocksys.find_right_side(A1, n, l)
x = blocksys.gaussian_elimination(A, n, l, b)
x1 = blocksys.gaussian_elimination(A1, n, l, b1)
@assert b == b1
@assert x == x1