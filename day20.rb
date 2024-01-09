#### Input parsing ####
puts '---LOADING INPUT-----'
input = File.read("day20.txt").split("\n")
flipflop = input.select{_1[0] == ?%}.map{|line| [line[1..].split(" -> ")[0].to_sym,line[1..].split(" -> ")[1].split(', ').map(&:to_sym)]}.to_h
inverter = input.select{_1[0] == ?&}.map{|line| [line[1..].split(" -> ")[0].to_sym,line[1..].split(" -> ")[1].split(', ').map(&:to_sym)]}.to_h
broadcaster = input.select{_1[0] == ?b}.first.split("-> ")[1].split(', ').map(&:to_sym)


invMem = inverter.keys.map{|k| [k,input.select{|line| line.split(" -> ")[1].include?(k.to_s)}.map{|line| [line.split(' ->')[0][1..].to_sym,:low]}.to_h]}.to_h
flipstates = flipflop.keys.map{|k| [k,:low]}.to_h
puts "flipflop"
puts flipflop.inspect
puts '------'
puts "inverter"
puts inverter.inspect
puts '------'
puts broadcaster.inspect
puts '------'
puts "inv memory"
puts invMem.inspect
puts '------'
puts "flipstates"
puts flipstates.inspect
puts '--LOADING FINISHED---'

STEPS = 10_000_000_000
pulsequeue = []
results = {:low => 0, :high => 0}

#part 1
1.upto(STEPS){|i|
    puts "#{i}" if i % 100_000 == 0
    rx_hits = 0
    results[:low] += 1 #button pulse
    broadcaster.each{|d| pulsequeue.push([:broadcaster,d,:low])}

    while pulsequeue.size > 0 do
        from,to,strength=pulsequeue.shift
        from_next = to
        #puts [from,to,strength].inspect
        results[strength]+=1
        if flipflop.key? to
            if strength == :low
                flipstates[to] = [:low,:high][[:high,:low].index(flipstates[to])]
                strength_next = flipstates[to]
                flipflop[to].each{|d| pulsequeue.push([from_next,d,strength_next])}
                #results[strength_next]+=1
            end
        elsif inverter.key? to
            #puts "Checking inverter #{to}"
            #puts "Current state of memory = #{invMem[to].inspect}"
            invMem[to][from] = strength
            #puts "Current state of memory = #{invMem[to].inspect}"
            #puts invMem[to].values.all?{ |m| m == :high}
            if invMem[to].values.all?{ |m| m == :high}
                strength_next = :low
            else
                strength_next = :high
            end
            inverter[to].each{|inv| pulsequeue.push([from_next,inv,strength_next])}
            #results[strength_next]+=1
        elsif to == :output
            
        else
            rx_hits +=1 if strength == :low
        end
    end
    puts "Part 2 = #{i}" if rx_hits == 1
}
#puts results.values.inject :*
