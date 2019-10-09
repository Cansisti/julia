# Tomasz Beneś
# list 1, task 1

function calc_macheps(t)
	x = t(1)
	one = t(1)
	while x > 0
		y = x/2
		if one + y == one break end
		x = y
	end
	return x
end

function calc_eta(t)
	x = t(1)
	while x > 0
		y = x/2
		if y <= 0 break end
		x = y
	end
	return x
end

function calc_max(t)
	arr = t[]
	x = t(1)
	while !isinf(x)
		push!(arr, x)
		x *= 2
	end
	x = t(0)
	while true
		y = x + pop!(arr)
		if isinf(y) break end
		x = y
	end
	return x
end

ep16 = calc_macheps(Float16)
ep32 = calc_macheps(Float32)
ep64 = calc_macheps(Float64)

me16 = calc_eta(Float16)
me32 = calc_eta(Float32)
me64 = calc_eta(Float64)

mx16 = calc_max(Float16)
mx32 = calc_max(Float32)
mx64 = calc_max(Float64)

println("------- Results -------\n")

println("Macheps:")
println(ep16, "     ", eps(Float16))
println(ep32, "    ", eps(Float32))
println(ep64, "   ", eps(Float64))

println()

println("Eta:")
println(me16, "     ", nextfloat(Float16(0)))
println(me32, "    ", nextfloat(Float32(0)))
println(me64, "   ", nextfloat(Float64(0)))

println()

println("Floatmin:")
println(floatmin(Float16))
println(floatmin(Float32))
println(floatmin(Float64))

println()

println("Floatmax:")
println(mx16, "     ", floatmax(Float16(0)))
println(mx32, "    ", floatmax(Float32(0)))
println(mx64, "   ", floatmax(Float64(0)))