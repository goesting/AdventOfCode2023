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

#Init
worddirections = {[1,0]=> "East", [-1,0]=> "West", [0,-1]=> "North", [0,1]=>"South"}
grid = File.read('day16.txt').split("\n")

#Part 1
energized = grid.map{|line| (['....'] * line.size)}
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
    #find next position of laser(s) based on mirror
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
    #Update position
        currentlaser.x = currentlaser.x + currentlaser.direction[0]
        currentlaser.y = currentlaser.y + currentlaser.direction[1]
        laserqueue.push(currentlaser)
    end
end
p energized.sum{|line| line.reject{_1=='....'}.size}


#Part 2
bestresult = -1
#generate all starting points
startlasers = []
0.upto(grid[0].size){|i|
    startlasers.push(Laser.new(i,0,[0,1]))
    startlasers.push(Laser.new(i,grid.size,[0,-1]))
}
0.upto(grid.size){|i|
    startlasers.push(Laser.new(0,i,[1,0]))
    startlasers.push(Laser.new(grid[0].size,i,[-1,0]))
}
#Loop through all start points
while startlasers.size > 0
    #Reset shizzle
    energized = grid.map{|line| (['....'] * line.size)}
    laserqueue = []
    laserqueue.push startlasers.pop

    #Loop until current laser has reached all it can reach
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
        #find next position of laser(s) based on mirror
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
        #Update position
            currentlaser.x = currentlaser.x + currentlaser.direction[0]
            currentlaser.y = currentlaser.y + currentlaser.direction[1]
            laserqueue.push(currentlaser)
        end
    end
    bestresult = [bestresult,energized.sum{|line| line.reject{_1=='....'}.size}].max
end
p bestresult
