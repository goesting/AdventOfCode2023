#INPUT
f=File.read('day03.txt').split("\n").map &:chars
#PART1
#collect all symbol coordinates
symbols = []
f.each_with_index{|line,y|line.each_with_index{|ch,x| symbols << [x,y] unless ch =~ /[0-9\.]/}}

#Init vars
tmp = "" 
xmin = -1 #start index of currently viewed nr
result = 0

#Loop through chars
#-Append consecutive nrs to temp
#-Nr is complete? Check surroundings against symbols[]
f.each_with_index{|line,y|
    line.each_with_index{|ch,x|
        if ch =~ /[0-9]/
            tmp += ch
            xmin = x if xmin == -1
        else
            result += tmp.to_i if tmp!='' && symbols.any?{|hor,vert| (vert-y).abs<2 && (hor>=xmin-1 && hor <= x)}
            tmp  = ''
            xmin = -1
        end
    }
    #at the end of each row, manual check if number is there, or it will stick to number on start of next line
    result += tmp.to_i if tmp!='' && symbols.any?{|hor,vert| (vert-y).abs<2 && hor>=xmin-1}
    tmp  = ''
    xmin = -1
}
p result

#PART2
#collect '*'symbol coordinates only
symbols = []
f.each_with_index{|line,y|line.each_with_index{|ch,x| symbols << [x,y] if ch == '*'}}

#Init vars
result2 = []
xmin = -1 #horizontal coord, indicates start of current number

#Loop through chars
#-Append consecutive nrs to temp
#-Nr is complete? Check surroundings against symbols[]
#--Add nr to result2[] if * is found
f.each_with_index{|line,y|
    line.each_with_index{|ch,x|
        if ch =~ /[0-9]/
            tmp += ch
            xmin = x if xmin == -1
        else
            symbols.select{|hor,vert| (vert-y).abs<2 && (hor>=xmin-1 && hor <= x)}.each{|symb|
                result2 << [symb,tmp.to_i] if tmp!=''
            }
            tmp  = ''
            xmin = -1
        end
    }
    #at the end of each row, manual check if number is there, or it will stick to number on start of next line
    symbols.select{|hor,vert| (vert-y).abs<2 && hor>=xmin-1}.each{|symb|
        result2 << [symb,tmp.to_i] if tmp!=''
    }
    tmp  = ''
    xmin = -1
}

#Result2 array is repeated ['*'-coords, number]
#Juggle result2[] array around to get hash of: {'*'-coord => [all nearby numbers]}, then easy select and sum.
puts result2.group_by{_1.shift}.select{|k,v|v.size==2}.transform_values(&:flatten).sum{|k,v| v.inject(:*)}
