input = File.read("Day10.txt").split
y_start = -1
x_start = -1

input.each_with_index{|x,i|
    if x.include? ?S
        y_start = i
        x_start = x.index ?S
    end
}
status = input.map{[['0',[0,0]]]*_1.size}
#puts status.inspect
steps = []
steps << [x_start,y_start]

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
status[y_start][x_start] = ['1',next_direction] #part of loop

x_now,y_now = [x_start,y_start].zip(next_direction).map &:sum
steps << [x_now,y_now]
status[y_now][x_now] = ['1',next_direction]


until x_now == x_start && y_now == y_start
    letter = input[y_now][x_now]
    prev_direction = next_direction
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
    if prev_direction[1].abs > 0
        direction = prev_direction
    else
        direction = next_direction
    end
    status[y_now][x_now] = ['1',direction]
    #puts "-- New letter #{letter}, going direction #{next_direction.inspect}"
    x_now,y_now = [x_now,y_now].zip(next_direction).map &:sum
    steps << [x_now,y_now]
    #status.each{puts _1}
    #puts '-----------------'
end
puts steps.size/2
#status.each{puts _1.inspect}

#part2
result = 0
status.each_with_index{|line,i|

while line.size >0 && line[-1][0] == '0'
    line = line[..-2]
end
    inside = false
    prevChar = ''
    prevDir = [0,0]
    line.each_with_index{|couple,j|
        c = couple[0]
        dir = couple[1]
        if c=='1' && (dir == prevDir.map{_1*-1} || prevDir==[0,0])
            inside = !inside
            prevDir = dir
        end
        prevChar = c
        
        if c != '1' && inside
            #puts "Result found on line #{i}, location #{j}"
            result +=1
        end
    }

}
p result
