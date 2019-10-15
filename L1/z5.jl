# Tomasz Beneś
# list 1, task 5

function dotA(x, y)
	t = typeof(x[1])
	s = t(0)
	for i in 1:5
		s += x[i] * y[i]
	end
	return s
end

function dotB(x, y)
	t = typeof(x[1])
	s = t(0)
	for i in 1:5
		s += x[6-i] * y[6-i]
	end
	return s
end

function dotC(x, y)
	t = typeof(x[1])
	sp = t(0) # positive sum
	sn = t(0) # negative sum
	si = t[]
	for i in 1:5
		push!(si, x[i] * y[i])
	end
	sort!(si)
	first_negative_index = 5
	for i in 1:5
		if si[6-i] >= 0
			sp += si[6-i];
			first_negative_index -= 1
		else
			sn += si[first_negative_index + 6 - i + 1]
		end
	end
	return sn+sp
end

function dotD(x, y)
	t = typeof(x[1])
	sp = t(0) # positive sum
	sn = t(0) # negative sum
	si = t[]
	for i in 1:5
		push!(si, x[i] * y[i])
	end
	sort!(si)
	first_positive_index = 1
	for i in 1:5 if si[i] >= 0
		first_positive_index = i
		break
	end end
	for i in 1:(first_positive_index - 1)
		sn += si[first_positive_index - i]
	end
	for i in first_positive_index:5
		sp += si[i]
	end
	return sn+sp
end

x = Float64[]
push!(x, 2.718281828)
push!(x, -3.141592654)
push!(x, 1.414213562)
push!(x, 0.5772156649)
push!(x, 0.3010299957)

y = Float64[]
push!(y, 1486.2497)
push!(y, 878366.9879)
push!(y, -22.37492)
push!(y, 4773714.647)
push!(y, 0.000185049)

println("------- Results -------\n")

println(dotA(x, y))
println(dotB(x, y))
println(dotC(x, y))
println(dotD(x, y))
