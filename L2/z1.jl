# Tomasz Beneś
# list 1, task 5

# Liczy iloczyn skalarny wektorów x i y sumując w przód
function dotA(x, y)
	t = typeof(x[1]) # Pobiera typ podanych wektorów
	s = t(0) # Suma
	for i in 1:5
		s += x[i] * y[i]
	end
	return s
end

# Liczy iloczyn skalarny wektorów x i y sumując w tył
function dotB(x, y)
	t = typeof(x[1]) # Pobiera typ podanych wektorów
	s = t(0) # Suma
	for i in 1:5
		s += x[6-i] * y[6-i]
	end
	return s
end

function dotC(x, y)
	t = typeof(x[1]) # Pobiera typ podanych wektorów
	sp = t(0) # Suma pozytywna
	sn = t(0) # Suma negatywna
	si = t[] # Wyniki kolejnych mnożeń
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
	t = typeof(x[1]) # Pobiera typ podanych wektorów
	sp = t(0) # Suma pozytywna
	sn = t(0) # Suma negatywna
	si = t[] # Wyniki mnożeń
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

x = Float64[] # Wektor x w podwójnej precyzji
push!(x, 2.718281828)
push!(x, -3.141592654)
push!(x, 1.414213562)
push!(x, 0.577215664)
push!(x, 0.301029995)

y = Float64[] # Wektor y w podwójnej precyzji
push!(y, 1486.2497)
push!(y, 878366.9879)
push!(y, -22.37492)
push!(y, 4773714.647)
push!(y, 0.000185049)

x32 = Float32[] # Wektor x w pojedynczej precyzji
push!(x32, 2.718281828)
push!(x32, -3.141592654)
push!(x32, 1.414213562)
push!(x32, 0.577215664)
push!(x32, 0.301029995)

y32 = Float32[] # Wektor y w pojedynczej precyzji
push!(y32, 1486.2497)
push!(y32, 878366.9879)
push!(y32, -22.37492)
push!(y32, 4773714.647)
push!(y32, 0.000185049)

println("------- Results -------\n")

println("Float64")
println(dotA(x, y))
println(dotB(x, y))
println(dotC(x, y))
println(dotD(x, y))

println("Float32")
println(dotA(x32, y32))
println(dotB(x32, y32))
println(dotC(x32, y32))
println(dotD(x32, y32))
