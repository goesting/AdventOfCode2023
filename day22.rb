class Point
    attr_accessor :x, :y, :z
    def initialize(coords)
        @x,@y,@z = coords
    end
    def to_s
        "[#{x},#{y},#{z}]"
    end
    def -(p)
        Point.new([self.x-p.x, self.y-p.y, self.z-p.z])
    end
    def +(p)
        Point.new([self.x+p.x, self.y+p.y, self.z+p.z])
    end
    def to_a
        [self.x,self.y,self.z]
    end
    def *(other)
        Point.new([self.x * other, self.y * other, self.z * other])
    end
end
class Block
    attr_accessor :start, :end
    def initialize(se)
        @start, @end = se
    end
    def size
        self.directionVector.to_a.sum
    end
    def directionVector
        puts "Subtracting #{@end} and #{@start}"
        (@end - @start)
    end
    def all_points
        [*(0..self.size)].map{|c| @start + self.directionVector * c}
    end
    def overlap(other)
        return (self.all_points & other.all_points).size > 0
        #if self.directionVector.map{_1/self.size} == other.directionVector.map{_1/other.size}
            #return (self.start - other.start).count(2) == 2
        #else
            
        #end

    end
    def drop(i)
        @start.z -=i
        @end.z-=i
    end
    def raise(i)
        @start.z +=i
        @end.z +=i
    end
    def to_s
        "#{self.start.to_s} -> #{self.end.to_s}"
    end
end
class Array
    def +(arr) #overwriting + on arrays cause i want to
        [self,arr].transpose.map(&:sum)
    end
    def *(i)
        self.map{_1*i}
    end
end

input = File.read("day22.txt").split("\n")

#part 1

blocks = input.map{|line| Block.new(line.split('~').map{|coords| Point.new(coords.split(',').map(&:to_i))})}
puts"read"
puts blocks
puts "drop"
puts blocks[0].directionVector.inspect
grid = {}
#Drop all blocks down
stilldropping = true
while stilldropping
    stilldroppping = false
    blocks.each{|block|
        #drop z by 1
        block.drop(1)
        #check for overlap or out of bounds
        if blocks.any?{|other| other != block && block.overlap(other)} || block.start.z < 0 || block.end.z < 0
            puts "contact"
            block.raise(1)
        else
            stilldropping = true
        end
    }
end

blocks.each{|b| puts b.to_s}
