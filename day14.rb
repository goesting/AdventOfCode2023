def roll(tensor, direction = :none)
    #turn the grid, so the rocks flow left every time. for easy ruby one-liner handling
    tensor = case direction
        when :none then roll(roll(roll(roll(tensor,:N),:W),:S),:E)
        when :W    then tensor
        when :E    then tensor.map &:reverse
        when :N    then tensor.transpose
        when :S    then tensor.reverse.transpose
    end

    #Roll balls left
    tensor = tensor.map{|line| line.slice_when{|a,b| (a=='#') ^ (b=='#')}.map{_1.sort.reverse}.flatten} unless direction == :none
    
    #Undo the turning of the grid
    tensor = case direction
        when :N   then tensor.transpose
        when :E   then tensor.map &:reverse
        when :S   then tensor.transpose.reverse
        when :W   then tensor
        else tensor
    end

    #return the grid
    tensor
end

#####Read input#####
input = File.read('day14.txt').split
#add #-borders to ease catching method
input = (['#'*(input[0].size+2)] + input.map{'#'+_1+'#'} + ['#'*(input[0].size+2)]).map(&:chars)

#####part 1#####
puts roll(input,:N).map.with_index{|line,i| line.sum{|c| c=='O' ? line.size-i-1 : 0} }.sum

#####part2#####
STEPS = 1_000_000_000
visitedStates = {} #DP dict of past configs to detect repeats. {state => i}

1.upto(STEPS){|i|
    if visitedStates.key?(input.join) #has been visited? check loop length and calc end point
        loopLength = i - visitedStates[input.join]
        loopRemainder = (STEPS - i) % loopLength + 1
        loopRemainder.times{input = roll(input)} #take steps upto the state that repeats at the end
        break
    else #add state to visited
        visitedStates[input.join] = i
    end
    input = roll(input) #keep rolling rolling rolling rolling. Move in, now move out, hand ups, now hands down. Back up back up, telle me what ya gonna do now?
}

#output
puts input.map.with_index{|line,i| line.sum{|c| c=='O' ? line.size-i-1 : 0} }.sum


