X=0
Y=1
Z=2
POS = 0
VEL = 1
MIN = 200000000000000
MAX = 400000000000000

input = File.read('day24.txt').split("\n")
input.map!{|line|
    line.split(' @ ').map{|side| side.split(', ').map(&:to_i)}
}
puts input.inspect

#part 1 XY only
puts input.combination(2).map{|hail1,hail2|
    hail1_slope = hail1[VEL][Y].to_f/hail1[VEL][X]
    hail2_slope = hail2[VEL][Y].to_f/hail2[VEL][X]

    if hail1_slope == hail2_slope #parallel
        x_cross = 0
        y_cross = 0
    else
        hail1_offset = hail1[POS][Y] - hail1_slope*hail1[POS][X]
        hail2_offset = hail2[POS][Y] - hail2_slope*hail2[POS][X]

        x_cross = (hail2_offset - hail1_offset)/(hail1_slope - hail2_slope)
        y_cross = hail1_slope * x_cross + hail1_offset
    end
    #Return 1 if within bounds and in the future, otherwise 0
    x_cross >= MIN && x_cross <= MAX && 
    y_cross >= MIN && y_cross <= MAX &&
    (hail1[POS][X] - x_cross)/hail1[VEL][X] < 0 &&
    (hail2[POS][X] - x_cross)/hail2[VEL][X] < 0 ? 1 : 0
}.sum
