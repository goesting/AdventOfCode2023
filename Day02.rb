MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

f = File.read('Day02.txt').split("\n").map{|line| 
    [line.split(':')[0].split[1].to_i,
     line.split(':')[1].split(';').map{|ballpull| 
        ballpull.split(',').map{|onepull| 
            [onepull.split[1],onepull.split[0].to_i]
            }.to_h
        }
    ]}.to_h

puts f.select{|k,v|
    v.all?{|x|
        (x["blue"].nil? || x["blue"]<=MAX_BLUE) &&
        (x["red"].nil? || x["red"]<=MAX_RED) &&
        (x["green"].nil? || x["green"]<=MAX_GREEN)
    }
}.sum{|g|g[0]}

puts f.sum{|k,v|
    v.map{|draw|
        [draw.fetch("red",0),
         draw.fetch("green",0),
         draw.fetch("blue",0)]
    }.transpose.map(&:max).reduce(:*)
}

