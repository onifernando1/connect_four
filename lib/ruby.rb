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
    # remove bottom, playermove board  current player after testing 
    attr_accessor :new_board, :bottom, :player_move, :board, :current_player, :next_move
    
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
        @next_move = false 
        @win = false 

    end 

    def get_move
        @next_move = false 
        puts "#{@current_player.name}, select a collumn between 1 and 7"
        @player_move = gets.chomp
        @player_move = @player_move.to_i
        @player_move -= 1
        if @player_move < 0 || @player_move >= 7
            puts "INVALID MOVE!"
            get_move()
        end 
        # puts @player_move
    end 

    def make_move

        until next_move == true 
        
            @bottom = 5 

            until @board[@bottom][@player_move] == @new_board.circle || @bottom < 0
                @bottom -= 1 
            end 
            
            if @bottom < 0 
                puts "INVALID"
                break 
            else 
                @board[@bottom][@player_move] = @current_player.symbol
                @next_move = true
                if @current_player == @p1
                    @current_player = @p2
                else 
                    @current_player = @p1
                end
            end 
        end 

    end 

    def round 
        get_move()
        make_move()
        @new_board.show_board()
    end 

    def play 

        until @win == true 
            round()

        end 

    end 

end 

game = Game.new()
game.play()



puts game.board[0][0] ==  game.new_board.circle
puts game.current_player.symbol == game.new_board.circle
