#prep
def getrankfromhand(hand)
    if fiveofakind? hand
        return 1
    elsif fourofakind? hand
        return 2
    elsif fullhouse? hand
        return 3
    elsif threeofakind? hand
        return 4
    elsif twopair? hand
        return 5
    elsif pair? hand
        return 6
    else
        return 7
    end
end
def fiveofakind?(s)
    s.chars.uniq.size == 1
end
def fourofakind?(s)
    s.chars.tally.map{_1[1]}.max == 4
end
def fullhouse?(s)
    s.chars.uniq.size == 2 #only works if test is done after 4ofakind
end
def threeofakind?(s)
    s.chars.tally.map{_1[1]}.max == 3
end
def twopair?(s)
    s.chars.tally.map{_1[1]}.count(2) == 2
end
def pair?(s)
    s.chars.uniq.size == 4
end
fiveofakind  = proc(&:fiveofakind?)
fourofakind  = proc(&:fourofakind?)
fullhouse    = proc(&:fullhouse?)
threeofakind = proc(&:threeofakind?)
twopair      = proc(&:twopair?)
pair         = proc(&:pair?)
#input
game=File.read('day07.txt').split("\n").map{|line| {:hand=>line.split[0],:bet=>line.split[1].to_i}}

#part1
#puts game.inspect
game.each{|person| person[:handtype] = getrankfromhand(person[:hand])}
game.map(&:to_a).sort_by{_1[0][1].tr("TJQKA","abcde")}.reverse.sort_by{|person| person[2][1]}.reverse.each{puts _1[0][1]}#.map.with_index{|person,i| person[1][1]*(i+1)}.sum
