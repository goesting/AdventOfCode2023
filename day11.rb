#input
f = File.read("Day11.txt").split("\n").map(&:chars)
y_empty = f.map.with_index{|x,i|[x,i]}.select{|line| line[0].all?{|c| c == '.'}}.map{_1[1]}
x_empty = f.transpose.map.with_index{|x,i|[x,i]}.select{|line| line[0].all?{|c| c == '.'}}.map{_1[1]}

#part1
galaxies = []
y = y_withempty = 0
f.each{|line|
    while x=line.index('#')
        line[x] = '-'
        x += x_empty.count{|v| v<x}
        galaxies << [y_withempty,x]
    end
    y += 1
    y_withempty += 1
    y_withempty += 1 if y_empty.include?(y)
}

#part2
galaxies = []
y = y_withempty = 0
f.each{|line|
    while x=line.index('#')
        line[x] = '-'
        x += x_empty.count{|v| v<x} * 999_999
        galaxies << [y_withempty,x]
    end
    y += 1
    y_withempty += 1
    y_withempty += 999_999 if y_empty.include?(y)
}


puts "Empty columns = #{x_empty.inspect}"
puts "Empty rows = #{y_empty.inspect}"
puts "galaxy locations = #{galaxies.inspect}"
puts galaxies.combination(2).map{|a,b| (a[0]-b[0]).abs + (a[1]-b[1]).abs}.sum
