# Tomasz Beneś
# list 1, task 3, alternative solution

# Wypisuje binarne reprezentacje kolejnych czterech liczb z przedziału, oraz ostatnie dwie
# ax i ay są końcami przedziału
function test_delta(ax, ay)
	x = Float64(ax)
	x1 = nextfloat(x)
	x2 = nextfloat(x1)
	x3 = nextfloat(x2)
	y = Float64(ay)
	yn1 = prevfloat(y)

	println(bitstring(x))
	println(bitstring(x1))
	println(bitstring(x2))
	println(bitstring(x3))
	println(bitstring(yn1))
	println(bitstring(y))
end

println("------- Results -------\n")

println("------- [1, 2] --------")
test_delta(1, 2)

println("\n------- [0.5, 1] --------")
test_delta(0.5, 1)

println("\n------- [2, 4] --------")
test_delta(2, 4)