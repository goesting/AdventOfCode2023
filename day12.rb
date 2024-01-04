f=File.read("day12.txt").split("\n").map{|line| [line.split[0],line.split[1].split(',').map(&:to_i)]}
result = 0
line = f[0]
f.each{|line|
    text = line[0]
    nrs = line[1]

    q=text.count('?')
    r=2**q - 1
    0.upto(r){|i|
        bini = i.to_s(2).rjust(q,'0')
        #puts "bini = #{bini}"
        j=-1
        out = text.gsub('?'){|c|
            j+=1
            #puts bini[j]
            bini[j] == ?1 ? '#' : '.'
    }.chars.slice_when{|a,b| a!=b}.reject{_1[0]=='.'}.map(&:size)

        result += 1 if out == nrs
    }
    
}
puts result

#part2
#cant do bruteforce anymore
