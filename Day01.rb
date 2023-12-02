puts File.read('Day01.txt').split("\n").sum{|line|
    line.delete!("^0-9")
    (line[0] + line[-1]).to_i
}

icanread={"one"=>"1",
          "two"=>"2",
          "three"=>"3",
          "four"=>"4",
          "five"=>"5",
          "six"=>"6",
          "seven"=>"7",
          "eight"=>"8",
          "nine"=>"9"}
temp=""

puts File.read('Day01.txt').split("\n").sum{|line|
    temp,line = line,line.gsub(Regexp.new(icanread.keys*'|')){icanread[_1]+_1[1..]} while temp!= line
    line.delete!("^0-9")
    (line[0] + line[-1]).to_i
}
