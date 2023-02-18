=begin
Main lesssons learned:
Good to have hash back in my rotation.
ALWAYS USE .map(&:clone) TO DUPLICATE AN ARRAY CUZ ITS A POINTER OTHERWISE
Since chess has a limited board, setting up the whole board at the beginning is a straightforward choice.
The "nextMove" array is a first for me. I really like the simplicity.
Surprised by how easy it is to set the stop sign so the system won't go infinitely deep.
=end

class Knight
    attr_accessor :path, :step
    def initialize(path = Array.new{Array.new(2)}, step = -1)
        @path = path
        @step = step
    end
end

def knight(stL,fnL)
    $board = Hash.new
    for a in 1..8 do
        for b in 1..8 do
            str = "#{a},#{b}"
            $board[str] = Knight.new
        end
    end
    $board["#{stL[0]},#{stL[1]}"].path.push(stL)
    $board["#{stL[0]},#{stL[1]}"].step += 1
    cuL = stL
    move(cuL, fnL)
    puts
    puts "------ RESULT ------"
    puts "You ask for the path between #{stL.inspect} and #{fnL.inspect}"
    puts "The shortest path is..."
    puts $board["#{fnL[0]},#{fnL[1]}"].path.inspect
    puts "It is made in #{$board["#{fnL[0]},#{fnL[1]}"].step} moves."
    puts"--- END OF RESULT ---"
    puts
end

def move(cuL, fnL)
    move = [[1, 2], [-2, -1], [-1, 2], [2, -1],[1, -2], [-2, 1], [-1, -2], [2, 1]]
    move.each do |nextMove|
        nextL = cuL.map(&:clone)
        nextL[0] += nextMove[0]
        nextL[1] += nextMove[1]
        eval(cuL, nextL, fnL)
    end
end

def eval(lastL, cuL, fnL)
    #puts "Evaluating #{cuL[0]},#{cuL[1]}, from #{lastL[0]},#{lastL[1]}"
    if $board["#{cuL[0]},#{cuL[1]}"] == nil
        #puts "Returning because it's not on board."
        return
    else
        #puts "Valid move."
        step2p = $board["#{lastL[0]},#{lastL[1]}"].step + 1
        p2p = $board["#{lastL[0]},#{lastL[1]}"].path.map(&:clone)
        if (step2p >= $board["#{cuL[0]},#{cuL[1]}"].step && $board["#{cuL[0]},#{cuL[1]}"].step != -1)
            #puts "Returning cuz the path is not shorter."
            return
        else
            $board["#{cuL[0]},#{cuL[1]}"].path = p2p
            $board["#{cuL[0]},#{cuL[1]}"].path.push(cuL)
            $board["#{cuL[0]},#{cuL[1]}"].step = step2p
        end
    end
    if cuL == fnL
        #puts "We found a path!!!"
        #puts $board["#{cuL[0]},#{cuL[1]}"].path.inspect
        #puts "Total steps: #{$board["#{cuL[0]},#{cuL[1]}"].step}"
        #puts
        return
    else move(cuL, fnL)
    end
end

# Please use 1 to 8
# Please do not use 0 to 7
# I am too lazy to put in a validation function

knight([4,4],[5,4])
knight([1,1], [4,4])
knight([1,1], [2,3])
knight([4,4], [1,1])