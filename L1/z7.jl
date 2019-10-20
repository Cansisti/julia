# Tomasz Beneś
# list 1, task 7

# Zwraca przybliżoną wartość pochodnej funkcji f w punkcie x względem przesunięcia h
function afp(f, x, h)
	return (f(x+h) - f(x))/h
end

# Funkcja f z zadania
function f(x)
	return sin(x)+cos(3*x)
end

# Punkt x0 z zadania
x = Float64(1)

for i in 0:54
	h = Float64(2)^-i
	v = afp(f, x, h)
	println(i, " ", v, "   ", x+h)
end