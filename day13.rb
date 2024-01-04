patterns = File.read("day13.txt").split("\n\n").map{|pattern| pattern.split}


result = patterns.map{|pattern| 
mirrorisat = -1
    #Check horizontal mirror
    0.upto(pattern.size-2){|mirrorLocation|
        pre = pattern[..mirrorLocation].reverse
        post = pattern[mirrorLocation+1..]
        minsize = [pre.size,post.size].min
        #puts "Comparing these two:"
        #puts pre[...minsize].inspect
        #puts post[...minsize].inspect
        if pre[...minsize] == post[...minsize]
            mirrorisat = (mirrorLocation+1)*100
        end
    }
    #Check vertical mirror
    flipped = pattern.map(&:chars).transpose.map(&:join)
    0.upto(flipped.size-2){|mirrorLocation|
        pre = flipped[..mirrorLocation].reverse
        post = flipped[mirrorLocation+1..]
        minsize = [pre.size,post.size].min
        #puts "Comparing these two: \n"+ pre[...minsize].inspect + "\n" + post[...minsize].inspect
        if pre[...minsize] == post[...minsize]
            #puts "MATCH"
            mirrorisat = (mirrorLocation+1)
        end
    }

    mirrorisat
}
puts result.sum


#part2
result = patterns.map{|pattern| 
mirrorisat = -1
    #Check horizontal mirror
    0.upto(pattern.size-2){|mirrorLocation|
        if mirrorisat == -1
            pre = pattern[..mirrorLocation].reverse
            post = pattern[mirrorLocation+1..]
            minsize = [pre.size,post.size].min
            #puts "Comparing these two:"
            #puts pre[...minsize].inspect
            #puts post[...minsize].inspect
            zippy = pre[...minsize].zip(post[...minsize]).map{|l| l[0].chars.zip(l[1].chars).map{|k|k[0]==k[1] ? 0 : 1}.sum}.sum
            if zippy == 1
                mirrorisat = (mirrorLocation+1)*100
            end
        end
    }
    if mirrorisat == -1
        #Check vertical mirror
        flipped = pattern.map(&:chars).transpose.map(&:join)
        0.upto(flipped.size-2){|mirrorLocation|
            pre = flipped[..mirrorLocation].reverse
            post = flipped[mirrorLocation+1..]
            minsize = [pre.size,post.size].min
            #puts "Comparing these two: \n"+ pre[...minsize].inspect + "\n" + post[...minsize].inspect
            zippy = pre[...minsize].zip(post[...minsize]).map{|l| l[0].chars.zip(l[1].chars).map{|k|k[0]==k[1] ? 0 : 1}.sum}.sum
            if zippy == 1 && mirrorisat == -1
                mirrorisat = (mirrorLocation+1)
            end
        }
    end
    mirrorisat
}
puts result.sum
