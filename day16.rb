
class Laser
    attr_accessor :x, :y, :direction
    def initialize(x,y,direction)
        @x,@y,@direction = x,y,direction
    end
    def to_s
        worddirections = {[1,0]=> "East", [-1,0]=> "West", [0,1]=> "North", [0,-1]=>"South"}
        "Laser at (#{@x},#{@y}) moving #{worddirections[@direction]}"
    end
end
worddirections = {[1,0]=> "East", [-1,0]=> "West", [0,-1]=> "North", [0,1]=>"South"}
grid = File.read('day16.txt').split("\n")
energized = grid.map{|line| (['....'] * line.size)}
energized.each{puts _1.inspect}
laserqueue = []
laserqueue.push Laser.new(0,0,[1,0])

while laserqueue.size > 0
    currentlaser = laserqueue.pop
    #check if out of bounds
    if currentlaser.x < 0 || currentlaser.x >= grid[0].size ||
        currentlaser.y < 0 || currentlaser.y >= grid.size
    #check if position and direction has been seen already
    elsif energized[currentlaser.y][currentlaser.x].include? worddirections[currentlaser.direction][0]
        #do nothing i spose?
    else
    #set energized at current loc with direction to done
        energized[currentlaser.y][currentlaser.x] = energized[currentlaser.y][currentlaser.x][1..] + worddirections[currentlaser.direction][0]
    #find next position of laser(s)
        mirror = grid[currentlaser.y][currentlaser.x]
        if mirror == '.' || 
          (mirror == '-' && (currentlaser.direction==[1,0] || currentlaser.direction==[-1,0])) || 
          (mirror == '|' && (currentlaser.direction==[0,1] || currentlaser.direction==[0,-1]))
            #no direction changes
        elsif mirror == '\\'
            currentlaser.direction = currentlaser.direction.reverse
        elsif mirror == '/' 
            currentlaser.direction = currentlaser.direction.reverse.map{_1*-1}
        elsif mirror == '|'
            currentlaser.direction = [0,1]
            laserqueue.push(Laser.new(currentlaser.x,currentlaser.y-1,[0,-1]))
        elsif mirror == '-'
            currentlaser.direction = [1,0]
            laserqueue.push(Laser.new(currentlaser.x-1,currentlaser.y,[-1,0]))
        end
        currentlaser.x = currentlaser.x + currentlaser.direction[0]
        currentlaser.y = currentlaser.y + currentlaser.direction[1]
        laserqueue.push(currentlaser)
    end
    
    #energized.each{puts _1.inspect}
    #puts 'okpdsfkdsksdnvlknfdvlkjnsokvnslkdnv'
end
p energized.sum{|line| line.reject{_1=='....'}.size}
