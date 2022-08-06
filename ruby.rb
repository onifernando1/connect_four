require 'matrix'
require 'colorize'

# Pseudocode for connect 4 

# 1. Board - 7x6 - empty circles 
# 2. Input player names - player a and b 
# 3. Ask player 1 to go, select a collumn 
# 4. Place counter all the way to bottom of collum 
# 5. Ask player 2 to go, select a collumn, place counter to bottom 
# 6. Check_win? if four in a row vertically/horizontally/diagonally player x wins 
# 7. End Loop 

class Board 

    def make_board

        rows = 6
        columns = 7

        @board = Array.new(rows) do
            Array.new(columns) { "a" }
        end
    end 

    def show_board

    @temp = @board
    @board = @board.map {|array| array.join("")}
    puts @board
    @board = @temp


    end 

end 

board = Board.new()
board.make_board()
board.show_board()