# Tomasz Beneś

include("matrixgen.jl")

for i in 1000:1000:50000
	matrixgen.blockmat(i, 4, 10.0, "L5/Output/A$i.txt")
end
