input = File.read("Day10.txt").split
y_start = -1
x_start = -1

input.each_with_index{|x,i|
    if x.include? ?S
        y_start = i
        x_start = x.index ?S
    end
}
status = input.map{'0'*_1.size}


steps = []
steps << [x_start,y_start]
status[y_start][x_start] = '1' #part of loop
x_now = x_start
y_now = y_start
if    ['L','F','-'].include? input[y_start][x_start-1]
    next_direction = [-1,0]
elsif ['J','7','-'].include? input[y_start][x_start+1]
    next_direction = [1,0]
elsif ['F','7','|'].include? input[y_start-1][x_start] 
    next_direction = [0,-1]
elsif ['L','J','|'].include? input[y_start+1][x_start] 
    next_direction = [0,1]
else
    puts "By order of the Jarl, stop right there!"
end

x_now,y_now = [x_start,y_start].zip(next_direction).map &:sum
steps << [x_now,y_now]
status[y_now][x_now] = '1'


until x_now == x_start && y_now == y_start
    letter = input[y_now][x_now]
    next_direction = case letter
            when /[-|]/
                then next_direction
            when /[L7]/
                then next_direction.reverse
            when /[FJ]/
                then next_direction.reverse.map{_1*-1}
            else
                puts letter + " Criminal scum. stop right there"
        end
    puts "-- New letter #{letter}, going direction #{next_direction.inspect}"
    x_now,y_now = [x_now,y_now].zip(next_direction).map &:sum
    steps << [x_now,y_now]
    status[y_now][x_now] = '1'
    status.each{puts _1}
    puts '-----------------'
end
puts steps.size/2
status.each{puts _1}

#part2
