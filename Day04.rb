#INPUT
f=File.read('day04.txt').split("\n").map{|line| line.split(':')[1].split('|').map{|side| side.split.map(&:to_i)}}
#PART 1
p f.sum{|x| (2**((x[0] & x[1]).size - 1)).floor}
#PART 2
p f.map!{|x| [1,(x[0] & x[1]).size]}.each_with_index{|v,i| 1.upto(v[1]){|j|f[i+j][0]+=v[0] }}.sum{_1[0]}
