function xn1(xn0, c)
    return xn0^2 + c
end

function xn40(xn0, c)
    r = xn0
    for i = 1:40
        r = xn1(r, c)
    end
    return r
end

function t1()
    c = -2.0
    x0 = 1.0

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

function t2()
    c = -2.0
    x0 = 2.0

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

function t3()
    c = -2.0
    x0 = 1.99999999999999

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

function t4()
    c = -1.0
    x0 = 1.0

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

function t5()
    c = -1.0
    x0 = 0.75

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

function t6()
    c = -2.0
    x0 = 1.0

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

function t7()
    c = -1.0
    x0 = 0.25

    println("--- ", x0, " ", c, " ", xn40(x0, c))
end

t1()
t2()
t3()
t4()
t5()
t6()
t7()