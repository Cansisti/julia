# Tomasz Beneś
# list 2, task 5.1

function pn1(pn0, r)
    return pn0 + r*pn0*(1-pn0)
end

p0 = Float32(0.01)
r = Float32(3)

w = p0

for i = 1:40
    global w = pn1(w, r)
end

v = p0

for i = 1:10
    global v = pn1(v, r)
end
v = 0.722
for i = 1:30
    global v = pn1(v, r)
end

println(w)
println(v)