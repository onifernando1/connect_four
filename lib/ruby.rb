require 'colorize'

# Pseudocode for connect 4 

# 1. Board - 7x6 - empty circles 
# 2. Input player names - player a and b 
# 3. Ask player 1 to go, select a collumn 
# 4. Place counter all the way to bottom of collum 
# 5. Ask player 2 to go, select a collumn, place counter to bottom 
# 6. Check_win? if four in a row vertically/horizontally/diagonally player x wins 
# 7. End Loop 

class Board attr_accessor :board

    def make_board

        @board = Array.new(6) {Array.new(7,"a")}
    end 

    def show_board

        @temp = @board
        @board = @board.map {|array| array.join("")}
        puts @board
        @board = @temp


    end 

    def change_board(column,row, symbol)
         @board[row][column] = symbol 
        
    end 

end 

class Player 
    attr_accessor :p1_name, :p2_name
    
   

    def get_player_names
        puts "Enter player one name:"
        @p1_name = gets.chomp()
        puts "Enter player one name:"
        @p2_name = gets.chomp()
        @p1_name, @p2_name
    end 

    def create_players 
        p1 = PlayerOne.new(@p1_name)
        p2 = PlayerTwo.new(@p2_name)
    end 



end 

class PlayerOne < Player

    def initialize(p1_name)
        @p1_name = p1_name
    end 

end 

class PlayerTwo < Player

    def initalize(p2_name)
        @p2_name = p2_name
    end 

end 

board = Board.new()
board.make_board()
# board.show_board()
board.change_board(1,3,"X")
board.show_board()
player = Player.new()