time,distance = File.read("day06.txt").split("\n")
time = time.split(':')[1].split.map &:to_i
distance = distance.split(':')[1].split.map &:to_i
race = time.zip(distance)
puts race.map{|t,record_distance|
    best_speed = t/2
    best_distance = (t-best_speed)*best_speed
    cur_speed = best_speed
    cur_distance = best_distance
    ways_to_win = 0
    
    #find lower limit
    while(cur_distance > record_distance)
        #puts "O hi, i can do #{cur_distance} by going #{cur_speed} speed. The record is only #{record_distance}. Ways to win = #{ways_to_win + 1}"
        ways_to_win += 1
        cur_distance = (cur_distance/(cur_speed)+1)*(cur_speed-1)
        cur_speed -=1
    end
    #find upper limit
    cur_speed = best_speed +=1
    cur_distance = (t-cur_speed)*cur_speed
    while (cur_distance > record_distance)
        #puts "O hi, i can do #{cur_distance} by going #{cur_speed} speed. The record is only #{record_distance}"
        ways_to_win +=1
        cur_distance = (cur_distance/(cur_speed)-1)*(cur_speed+1)
        cur_speed +=1
    end
    ways_to_win
}.inject :*


#part 2
time,distance = File.read("day06.txt").split("\n")
t = time.delete("^0-9").to_i
record_distance = distance.delete("^0-9").to_i
best_speed = t/2
    best_distance = (t-best_speed)*best_speed
    cur_speed = best_speed
    cur_distance = best_distance
    ways_to_win = 0
    
    #find lower limit
    while(cur_distance > record_distance)
        #puts "O hi, i can do #{cur_distance} by going #{cur_speed} speed. The record is only #{record_distance}. Ways to win = #{ways_to_win + 1}"
        ways_to_win += 1
        cur_distance = (cur_distance/(cur_speed)+1)*(cur_speed-1)
        cur_speed -=1
    end
    #find upper limit
    cur_speed = best_speed +=1
    cur_distance = (t-cur_speed)*cur_speed
    while (cur_distance > record_distance)
        #puts "O hi, i can do #{cur_distance} by going #{cur_speed} speed. The record is only #{record_distance}"
        ways_to_win +=1
        cur_distance = (cur_distance/(cur_speed)-1)*(cur_speed+1)
        cur_speed +=1
    end
    puts ways_to_win
