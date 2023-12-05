def remove_subrange(original_low,original_high, remove_low, remove_high, add_low, add_high)
    if remove_low > original_high or remove_high < original_low
        return [[original_low,original_high]]
    elsif remove_low <= original_low && remove_high >= original_high
        return [[add_low, add_high]]
    elsif remove_low <= original_low
        return [[remove_high+1,original_high],[add_low + (original_low-remove_low),add_high]]
    elsif remove_high >= original_high
        return [[original_low, remove_low-1],[add_low, add_high - (remove_high-original_high)]]
    elsif remove_low > original_low && remove_high < original_high
        return [[original_low,remove_low-1],[add_low,add_high],[remove_high+1,original_high]]
    else
        puts "You're not supposed to be back here. GUARDS!"
        puts [original_low,original_high, remove_low, remove_high, add_low, add_high].inspect
    end
end

seeds, *f=File.read('day05.txt').split("\n")
seeds = seeds.split(':')[1].split.map &:to_i
seeds2 = seeds
f.each{|line|
if line =~ /[0-9]/ #line with numbers
    dest_start,origin_start,range = line.split.map &:to_i
    seeds2 = seeds.map.with_index{|id,i| 
    #puts "Checking #{id} between #{origin_start} and #{origin_start + range - 1}"
    #puts "Result = #{id.between?(origin_start, origin_start + range-1)}"
    
    id.between?(origin_start, origin_start + range-1) ? id-origin_start+dest_start : seeds2[i]}
    #puts seeds2.inspect
else
    seeds = seeds2
    #puts "-----------------------------"
end
}
#part 1
p seeds2.min

#part2
seeds, *f=File.read('day05.txt').split("\n")
seeds = seeds.split(':')[1].split.map(&:to_i).each_slice(2).to_a.sort
#seeds = seeds.map{|x| [x[0],x.sum]}.flatten.inspect #changeoverspots
seeds = seeds.map{|x| [x[0],x[0]+x[1]-1]}
seeds2 = []
puts "1#{seeds.inspect}"

f.each{|line|
if line =~ /[0-9]/ #line with numbers
    puts "hi"
    d_start,o_start,range = line.split.map &:to_i
    d_end = d_start + range - 1
    o_end = o_start + range - 1 
    #puts "Starting remove with low: #{low}, high: #{high}"
    puts "2#{seeds.inspect}"
    seeds.each{|lh| 
        puts lh.inspect
        ur=remove_subrange(lh[0],lh[1],o_start,o_end, d_start, d_end)
        puts "return of remove func: #{ur.inspect}"
        ur.each{seeds2 << _1}
    }
else
    #Merge adjacent cells
    seeds2.sort!
    puts "abc"
    puts seeds2.inspect
    #overwrite original seeds
    seeds = seeds2 unless seeds2==[]
    seeds2 = []
end
}
puts seeds2.inspect

