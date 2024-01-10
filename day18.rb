class Array
    def +(arr) #overwriting + on arrays cause i want to
        [self,arr].transpose.map(&:sum)
    end
end
dir={'R'=>[1,0],'L'=>[-1,0],'U'=>[0,-1],'D'=>[0,1]}
#Part 1
input = File.read('day18.txt').split("\n").map{|line|[line.split[0],line.split[1].to_i]}
coords = []
pos=[0,0]
input.each{|f|
    direction = f[0]
    steps = f[1]
    steps.times{
        pos+=dir[direction]
        coords << pos
    }

}
puts coords.each_cons(2).reduce(0){|n, coords| n + coords[0][1]*coords[1][0]-coords[1][1]*coords[0][0]}.abs/2+coords.size/2+1

#part2
dir={'0'=>[1,0],'2'=>[-1,0],'3'=>[0,-1],'1'=>[0,1]}
input = File.read('day18.txt').split("\n").map{|line|line.split[2][2..-2]}.map{|hex| [hex[..4].to_i(16),hex[-1]]}
puts input.inspect
coords = []
pos=[0,0]
input.each{|f|
    direction = f[1]
    steps = f[0]
    pos+= dir[direction].map{_1*steps}
    coords << pos

}
puts coords.inspect
puts coords.each_cons(2).reduce(0){|n, coords| n + coords[0][1]*coords[1][0]-coords[1][1]*coords[0][0]}.abs/2+input.map{_1[0]}.sum/2+1
