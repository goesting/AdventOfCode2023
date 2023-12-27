#part 1
p File.read('day15.txt').split(',').sum{|line|line.chars.map{|c| c.ord}.inject(0){|result, x| (result+x)*17 % 256}}
#part 2
q = Array.new(256){|i| {}}
#puts q.inspect
input = File.read('day15.txt').split(',')
boxes = input.map{|cmd| cmd.split('=')[0].split('-')[0].chars.map{|c| c.ord}.inject(0){|result, x| (result+x)*17 % 256}}
boxes.each_with_index{|box,i|
    if input[i][-2] == '='
        q[box][input[i][..-3]] = input[i][-1] 
    elsif input[i][-1] == '-'
        q[box].delete(input[i][..-2])
    end
}
puts q.map.with_index{|box,i| box.values.map.with_index{|v,j| (i+1)*(j+1)*(v.to_i)}.sum}.sum
