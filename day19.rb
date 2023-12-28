def accepted(h,r,checkrule)
    while checkrule != :A && checkrule != :R
        r[checkrule].each{|rule|
        #puts "Checking #{h.inspect}"
        #puts "Against #{rule}"
            if rule == 'A'
                #puts "returning true"
                return true
            elsif rule == 'R'
                #puts "Returning false"
                return false
            elsif !rule.include? ?:
                deeper = accepted(h,r,rule.to_sym)
                #puts "returning #{deeper}"
               return deeper 
            else 
                stat = rule[0].to_sym
                sign = rule[1] == '<' ? 1 : -1
                target = rule.split(':')[0][2..].to_i
                destination = rule.split(':')[1].to_sym

                if h[stat]*sign < target*sign
                    return accepted(h,r,destination)
                end
            end
        }
    end
    return checkrule == :A
end

#PARSE INPUT
input = File.read('day19.txt')
rules,parts = input.split("\n\n")
rules = eval('{'+rules.gsub('{',"=>['").gsub(',',"','").gsub('}',"']").split.map{':'+_1}.join(",")+"}")
parts = parts.gsub('=','=>').gsub('x',':x').gsub('m',':m').gsub('a',':a').gsub('s',':s').split.map{eval(_1)}

#PART 1
p parts.sum{|line| accepted(line,rules,:in) ? line.values.sum : 0}
