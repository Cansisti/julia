# Tomasz Beneś
# list 1, task 2

# Oblicza macheps według wyrażenia Kahana dla danego typu t
function calc_macheps_Kahan(t)
	return t(3)*(t(4)/t(3)-t(1))-t(1)
end

# Macheps dla kolejnych typów
ep16 = calc_macheps_Kahan(Float16)
ep32 = calc_macheps_Kahan(Float32)
ep64 = calc_macheps_Kahan(Float64)

println("------- Results -------\n")

println("Macheps (Kahan):")
println(ep16, "     ", eps(Float16))
println(ep32, "    ", eps(Float32))
println(ep64, "   ", eps(Float64))