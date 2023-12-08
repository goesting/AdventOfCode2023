input = File.read("Day08.txt").delete('()').split("\n")
directions_raw = input[0].chars
path = input[2..].map{_1.split(' = ')}.to_h.transform_values{|v| {'L'=>v.split(', ')[0],'R'=>v.split(', ')[1]}}

#part1
iAmAt = 'AAA'
steps = 0
directions = directions_raw
until iAmAt == 'ZZZ'
    nextturn = directions.shift
    directions.push(nextturn)
    iAmAt = path[iAmAt][nextturn]
    steps +=1
end

puts steps

#part2
startlocations = path.keys.select{_1=~/..A/}
loopsteps = {}

startlocations.each{|origin|
    directions = directions_raw
    iAmAt = origin
    steps = 0
    until loopsteps.key?(origin) && loopsteps[origin].size > 1
        start = true
        until iAmAt=~/..Z/ and !start
            start = false
            nextturn = directions.shift
            directions.push(nextturn)
            iAmAt = path[iAmAt][nextturn]
            steps+=1
        end
        loopsteps[origin] = loopsteps.fetch(origin,[]) + [steps]
    end
}
puts loopsteps.values.map{|x|x[0]}.reduce(1) { |acc, n| acc.lcm(n) }
