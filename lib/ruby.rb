# frozen_string_literal: true

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
    @circle = " \u2B24".encode('utf-8').white
  end

  def make_board
    @board = Array.new(6) { Array.new(7, @circle) }
  end

  def show_board
    @temp = @board
    @board = @board.map { |array| array.join('') }
    puts @board
    @board = @temp
  end

  def change_board(column, row, symbol)
    @board[row][column] = symbol
  end
end

class Player
  attr_accessor :p1_name, :p2_name, :p1, :p2

  def get_p1_name
    puts 'Enter player one name:'
    @p1_name = gets.chomp
  end

  def get_p2_name
    puts 'Enter player two name:'
    @p2_name = gets.chomp
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
    @symbol = " \u2B24".encode('utf-8').red
  end
end

class PlayerTwo < Player
  attr_reader :name, :symbol

  def initialize(p2_name)
    @name = p2_name
    @symbol = " \u2B24".encode('utf-8').yellow
  end
end

class Game
  # remove bottom, playermove board p1 current player win after testing
  attr_accessor :next_move, :board

  def initialize
    @new_board = Board.new
    @new_board.make_board
    @board = @new_board.board
    @player = Player.new
    @player.get_p1_name
    @player.get_p2_name
    @player.create_players
    @p1 = @player.p1
    @p2 = @player.p2
    @current_player = @p1
    @next_move = false
    @win = false
    @p1_win = false
    @p2_win = false
    @moves = 0
    @new_board.show_board()
  end

  private

  def get_move
    @next_move = false
    puts "#{@current_player.name}, select a collumn between 1 and 7"
    @player_move = gets.chomp
    @player_move = @player_move.to_i
    @player_move -= 1
    if @player_move.negative? || @player_move >= 7
      puts 'INVALID MOVE!'
      get_move
    end
    @player_move
  end

  def make_move
    until next_move == true

      @bottom = 5

      @bottom -= 1 until @board[@bottom][@player_move] == @new_board.circle || @bottom.negative?

      if @bottom.negative?
        puts 'INVALID'
        break
      else
        @board[@bottom][@player_move] = @current_player.symbol
        @next_move = true
        @current_player = if @current_player == @p1
                            @p2
                          else
                            @p1
                          end
        @moves += 1
      end
    end
  end

  def check_win
    # Horizontal wins

    (0..5).each do |i|
      (0..3).each do |a|
        if @board[i][a] == @p2.symbol && @board[i][a + 1] == @p2.symbol && board[i][a + 2] == @p2.symbol && board[i][a + 3] == @p2.symbol
          @p2_win = true
          puts "#{@p2.name} WINS"
          @win = true
        elsif @board[i][a] == @p1.symbol && @board[i][a + 1] == @p1.symbol && board[i][a + 2] == @p1.symbol && board[i][a + 3] == @p1.symbol
          @p1_win = true
          puts "#{@p1.name} WINS"
          @win = true
        end
      end
    end

    # Vertical wins

    (0..2).each do |x|
      (0..6).each do |y|
        if @board[x][y] == @p1.symbol && @board[x + 1][y] == @p1.symbol && @board[x + 2][y] == @p1.symbol && @board[x + 3][y] == @p1.symbol
          @p1_win = true
          puts "#{@p1.name} WINS"
          @win = true
        elsif @board[x][y] == @p2.symbol && @board[x + 1][y] == @p2.symbol && @board[x + 2][y] == @p2.symbol && @board[x + 3][y] == @p2.symbol
          @p2_win = true
          puts "#{@p2.name} WINS"
          @win = true
        end
      end
    end

    # Left diagonals
    (0..2).each do |x|
      (0..3).each do |y|
        if @board[x][y] == @p1.symbol && @board[x + 1][y + 1] == @p1.symbol && @board[x + 2][y + 2] == @p1.symbol && @board[x + 3][y + 3] == @p1.symbol
          @p1_win = true
          puts "#{@p1.name} WINS"
          @win = true
        elsif @board[x][y] == @p2.symbol && @board[x + 1][y + 1] == @p2.symbol && @board[x + 2][y + 2] == @p2.symbol && @board[x + 3][y + 3] == @p2.symbol
          @p2_win = true
          puts "#{@p2.name} WINS"
          @win = true
        end
      end
    end

    # right diagonals
    (0..2).each do |x|
      (3..6).each do |y|
        if @board[x][y] == @p1.symbol && @board[x + 1][y - 1] == @p1.symbol && @board[x + 2][y - 2] == @p1.symbol && @board[x + 3][y - 3] == @p1.symbol
          @p1_win = true
          puts "#{@p1.name} WINS"
          @win = true
        elsif @board[x][y] == @p2.symbol && @board[x + 1][y - 1] == @p2.symbol && @board[x + 2][y - 2] == @p2.symbol && @board[x + 3][y - 3] == @p2.symbol
          @p2_win = true
          puts "#{@p2.name} WINS"
          @win = true
        end
      end
    end
  end

  def check_draw
    if @moves == 42 && @win == false
      puts 'DRAW!'
      @win = true
    end
  end

  def round
    get_move
    make_move
    @new_board.show_board
    check_win
    check_draw
  end

  public

  def play
    round until @win == true
  end
end

game = Game.new
game.play
