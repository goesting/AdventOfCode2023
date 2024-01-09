#################### method for part 1 #########################
# h         : 1 input line as a hash of the x,m,a,s params     # 
# r         : list of rules parsed from input                  #
# checkrule : name of the rule currently checking              #
# @returns  : true or false if h is accepted or not            #
################################################################
def accepted(h,r,checkrule)
    if checkrule != :A && checkrule != :R
        r[checkrule].each{|rule|
            if rule == 'A'
                return true
            elsif rule == 'R'
                return false
            elsif !rule.include? ?:
               return accepted(h,r,rule.to_sym)
            else 
                stat = rule[0].to_sym
                sign = rule[1] == '<' ? 1 : -1
                target = rule.split(':')[0][2..].to_i
                destination = rule.split(':')[1].to_sym
                
                return accepted(h,r,destination) if h[stat]*sign < target*sign
            end
        }
    end
    return checkrule == :A
end
#################### method for part 2 #########################
# r         : list of rules parsed from input                  #
# checkrule : name of the rule currently checking              #
# ranges    : hash of bottom and top acceptable x,m,a,s ranges #
# @returns  : count of all possible inputs to be accepted      #
################################################################
def accepted2(r,checkrule,ranges)
    if checkrule == :A
        result = (ranges[:x][:max]-ranges[:x][:min]+1)*(ranges[:m][:max]-ranges[:m][:min]+1)*(ranges[:a][:max]-ranges[:a][:min]+1)*(ranges[:s][:max]-ranges[:s][:min]+1)
    elsif checkrule == :R
        result = 0
    elsif ranges[:x][:min] > ranges[:x][:max] || ranges[:m][:min] > ranges[:m][:max] || ranges[:a][:min] > ranges[:a][:max] || ranges[:s][:min] > ranges[:s][:max]
        result = 0
    else
        result = 0
        r[checkrule].each{|rule|
            newranges = Marshal.load(Marshal.dump(ranges)) #make copy to edit without affecting original
            if rule == 'A'
                result += (ranges[:x][:max]-ranges[:x][:min]+1)*(ranges[:m][:max]-ranges[:m][:min]+1)*(ranges[:a][:max]-ranges[:a][:min]+1)*(ranges[:s][:max]-ranges[:s][:min]+1)
            elsif rule == 'R'
                result += 0
            elsif !rule.include? ?: #no conditional rule, just pointer. usually last
                result += accepted2(r,rule.to_sym,newranges)
            else # set new limits based on current rule for next recursion, and update current limits to be the opposite and check next rule with those
                stat = rule[0].to_sym
                target = rule.split(':')[0][2..].to_i
                destination = rule.split(':')[1].to_sym

                if rule[1] == '<'
                    newranges[stat][:max] = [newranges[stat][:max],target-1].min
                    ranges[stat][:min]    = [ranges[stat][:min],target].max
                else # '>'
                    newranges[stat][:min] = [newranges[stat][:min],target+1].max
                    ranges[stat][:max]    = [ranges[stat][:max],target].min
                end    
                result += accepted2(r,destination,newranges)
            end
        }
    end
    return result
end

#PARSE INPUT
input = File.read('day19.txt')
rules,parts = input.split("\n\n")
rules = eval('{'+rules.gsub('{',"=>['").gsub(',',"','").gsub('}',"']").split.map{':'+_1}.join(",")+"}")
parts = parts.gsub('=','=>').gsub('x',':x').gsub('m',':m').gsub('a',':a').gsub('s',':s').split.map{eval(_1)}

#PART 1
p parts.sum{|line| accepted(line,rules,:in) ? line.values.sum : 0}

#PART 2
ranges = {:x=>{:min=>1,:max=>4000},
          :m=>{:min=>1,:max=>4000},
          :a=>{:min=>1,:max=>4000},
          :s=>{:min=>1,:max=>4000}}

p accepted2(rules,:in,ranges)
