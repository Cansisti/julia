# Tomasz Beneś
# list 1, task 7

function afp(f, x, h)
	return (f(x+h) - f(x))/h
end

function f(x)
	return sin(x)+cos(3*x)
end

x = Float64(1)

for i in 0:54
	h = Float64(2)^i
	v = afp(f, x, h)
	println(i, " ", v)
end