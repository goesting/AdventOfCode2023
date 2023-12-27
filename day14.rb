input = File.read('day14.txt').split
input = (['#'*input[0].size] + input).map(&:chars).transpose
puts input.inspect
input.map!{|line|
    current = {}
    line.map.with_index{|c,i| 
        if  c=='O' 
            result = line.size - current.fetch(line[..i].rindex('#'),0) - (line[..i].rindex('#') || 0) - 1
            current[line[..i].rindex('#')]  = current.fetch(line[..i].rindex('#'),0)+1
            #puts current.inspect
        else
            result = 0
        end
        result
    }
}
puts input.inspect
puts input.map(&:sum).sum
