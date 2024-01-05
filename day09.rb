f=File.read("Day09.txt").split("\n").map{|line| line.split.map(&:to_i)}

p f.sum{|test|
lastdiff = []
lastdiff << test[-1]

until test.all?{ _1==0}
    test = test.each_cons(2).map{|a,b|b-a}
    lastdiff << test[-1]
    #puts test.inspect
end
lastdiff.sum
}

#p2
f=File.read("Day09.txt").split("\n").map{|line| line.split.map(&:to_i)}


puts f.map{|test|
flipflop = 1
lastdiff = []
lastdiff << test[0]*flipflop

until test.all?{ _1==0}
    test = test.each_cons(2).map{|a,b|b-a}
    flipflop *= -1
    lastdiff << test[0]*flipflop
    #puts test.inspect
end
lastdiff.sum
}.sum
