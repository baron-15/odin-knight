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
    $board.each do |key, value|
        #puts "#{key}:#{value.path}, #{value.step}"
    end
    
    move(cuL, fnL)
    puts
    puts "------ RESULT ------"
    puts "You ask for the path between #{stL.inspect} and #{fnL.inspect}"
    puts "The shortest path is..."
    puts $board["#{fnL[0]},#{fnL[1]}"].path.inspect
    puts "It is made in #{$board["#{fnL[0]},#{fnL[1]}"].step} moves."
    puts"--- END OF RESULT ---"
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
        path2p = $board["#{lastL[0]},#{lastL[1]}"].step + 1
        p2p = $board["#{lastL[0]},#{lastL[1]}"].path.map(&:clone)
        if (path2p >= $board["#{cuL[0]},#{cuL[1]}"].step && $board["#{cuL[0]},#{cuL[1]}"].step != -1)
            #puts "Returning cuz the path is not shorter."
            return
        else
            $board["#{cuL[0]},#{cuL[1]}"].path = p2p
            $board["#{cuL[0]},#{cuL[1]}"].path.push(cuL)
            $board["#{cuL[0]},#{cuL[1]}"].step = path2p
        end
    end
    if cuL == fnL
        #puts "We found a path!!!"
        #puts $board["#{cuL[0]},#{cuL[1]}"].path.inspect
        #puts "Total steps: #{$board["#{cuL[0]},#{cuL[1]}"].step}"
        #puts
        return
    elsif meaningless?($board["#{cuL[0]},#{cuL[1]}"].step)
        return
    else move(cuL, fnL)
    end
end

def meaningless?(inp)
    max = 0
    for a in 1..8 do
        for b in 1..8 do
            str = "#{a},#{b}"
            if $board[str].step == -1
                return false
            elsif $board[str].step > max
                max = $board[str].step
            end
        end
    end
    if inp > max
        return true
    else return false
    end
end

# Please use 1 to 8
# Please do not use 0 to 7
# I am too lazy to put in a verify function

knight([4,4],[5,4])
knight([1,1], [4,4])
knight([1,1], [2,3])
knight([4,4], [1,1])