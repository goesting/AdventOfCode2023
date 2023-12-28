STEPS = 64

input = File.read('day21.txt').split
width = input[0].size
height = input.size
input = (input*'')


1.upto(STEPS){|i|
temp = input.clone
    input.chars.each_with_index{|c,i|
        if c=='#'
            temp[i] = '#'
        elsif [input[i-1],input[i+1],input[i+width],input[i-width]].include? 'S'
            temp[i] = 'S'
        else
            temp[i] = '.'
        end
    }
input = temp.dup
#input.chars.each_slice(width){puts _1*''}
}
p input.count(?S)
