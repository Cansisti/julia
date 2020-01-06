i = 1000
out = open("L5/measure_pivot_error.txt", "w")
while i != 50000:
	file = open("L5/Output/xp" + str(i) + ".txt")
	line = file.readline()
	err = line.split()[0]
	out.write(err + "\n")
	file.close()
	i += 1000
out.close()