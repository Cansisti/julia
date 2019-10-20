# Tomasz Beneś
# list 1, task 3

function test_delta(d ::Float64, a ::Float64, b ::Float64)
	x = a
	y = nextfloat(a)
	while y <= b
		if y - x == d
			x = y
			y = nextfloat(y)
		else
			return false
		end
	end
	return true
end

println("------- Results -------\n")

# println("[1,2] step is 2^-52 :")
# println(test_delta(2.0 ^ (-52), 1.0, 2.0)) # true
# println("[0.5,1] step is 2^-53 :")
# println(test_delta(2.0 ^ (-53), 0.5, 1.0)) # true
# println("[2,4] step is 2^-51 :")
# println(test_delta(2.0 ^ (-51), 2.0, 4.0)) # true