# Tomasz Beneś
# list 2, task 5.2

function pn1(pn0, r)
    return pn0 + r*pn0*(1-pn0)
end

w = Float64(0.01)
rw = Float64(3)

for i = 1:40
    global w = pn1(w, rw)
end

v = Float32(0.01)
rv = Float32(3)

for i = 1:40
    global v = pn1(v, rv)
end

println(w)
println(v)