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
    attr_accessor :board, :circle

    def initialize 

        @circle = " \u2B24".encode("utf-8").white


    end 

    def make_board

        @board = Array.new(6) {Array.new(7,@circle)}
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
    attr_accessor :p1_name, :p2_name, :p1, :p2
    
   

    def get_p1_name
        puts "Enter player one name:"
        @p1_name = gets.chomp()
    end 

    def get_p2_name 
        puts "Enter player two name:"
        @p2_name = gets.chomp()
    end 

    def create_players 
        @p1 = PlayerOne.new(@p1_name)
        @p2 = PlayerTwo.new(@p2_name)
    end 



end 

class PlayerOne < Player
    attr_reader :name, :symbol

    def initialize(p1_name)
        @name = p1_name
        @symbol = " \u2B24".encode("utf-8").red

    end 

end 

class PlayerTwo < Player
    attr_reader :name, :symbol

    def initialize(p2_name)
        @name = p2_name
        @symbol = " \u2B24".encode("utf-8").yellow

    end 

end 

class Game
    
    attr_accessor :new_board
    
    def initialize 
        @new_board = Board.new()
        @new_board.make_board()
        @board = @new_board.board
        @player = Player.new()
        @player.get_p1_name
        @player.get_p2_name
        @player.create_players
        @p1 = @player.p1
        @p2 = @player.p2
        @current_player = @p1        
    end 

    def get_move
        puts "#{@current_player.name}, select a collumn"
        @player_move = gets.chomp.to_i
        @player_move -=1
        puts @player_move
    end 

    def make_move
       
        @bottom = 5 

        until @board[@player_move][@bottom] === @new_board.circle || @bottom < 0
            puts "BOTTOM IS #{@bottom}"
            @bottom -= 1 
        end 
        
        if @bottom < 0 
            puts "INVALID"
        else 
            puts "BOTTOM IS #{@bottom}"
            @board[@bottom][@player_move] = @current_player.symbol
        end 


    end 

end 

game = Game.new()
game.get_move()
game.make_move()
game.new_board.show_board()
game.get_move()
game.make_move()
game.new_board.show_board()
