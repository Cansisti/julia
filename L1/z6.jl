# Tomasz Beneś
# list 1, task 6

function f(x)
	return sqrt(x*x+1)-1
end

function g(x)
	return (x*x)/(sqrt(x*x+1)+1)
end

println("------- Results -------\n")

for i in 1:10
	x = Float64(8.0^i)
	println(i, " ", x, " ", f(x), " ", g(x), " ", f(x)-g(x));
end
