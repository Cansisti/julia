# Tomasz Beneś
# list 1, task 4

# Znajduje liczbę w przedzale (1,2) opisaną w zadaniu
function find_it()
	x = nextfloat(Float64(1.0))
	while x*(1.0/x) == 1
		x = nextfloat(x)
		if x == 2.0 return 0.0 end
	end
	return x
end

x = find_it() # Szukana liczba
println(x)
println(bitstring(x))
println(bitstring(1/x))