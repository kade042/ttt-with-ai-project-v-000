class Game
  attr_accessor :player_1, :player_2, :board
  def initialize(player_1=Player::Human.new("X"), player_2=Player::Human.new("O"), board=Board.new.tap{|b| b.cells})
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5],
    [6,7,8], [0,3,6],
    [1,4,7], [2,5,8],
    [0,4,8], [6,4,2]
  ]

  def full?
    !(@board.cells.include?(" "))
  end

  def draw?
    board.draw?
  end

  def over?
    board.over?
  end

  def winner
    board.winner
  end

  def current_player
    turn_count % 2 == 0 ? player_1 : player_2
  end

  def turn_count
    @board.cells.count {|token| token == "X" || token == "O"}
  end

  def won?
    board.won?
  end

  def turn
    current_player.tap {|player| player.move(board)}
    board.display
  end

  def play

    10.times do
      if !over? && !(won?.is_a?(Array)) && !draw?
        turn
      elsif board.draw?
        puts "Cats Game!"

      elsif (winner != nil  && over?)
        puts "Congratulations #{winner}!"
        break
      end
    end
  end

  def user_interface
    puts "/////////////       Welcome to Tic Tac Toe!         //////////////////////"
    puts "//////////////////  Ex: '1' would move you to the 1st column, 1st row //////////////\n"
    puts "                    To start the game enter: start"
    puts "                    Press 'q' to Quit"

    input = gets.strip
    case input.downcase
    when "start"
        puts "              To choice player mode enter: mode"
      input1 = gets.strip
      case input1.downcase
        when "mode"
          puts "              Enter: 1 for 1 Player mode"
          puts "              Enter: 2 for 2 Player mode"
          puts "              Enter: auto for autonomous mode"
          input2 = gets.strip
          case input2
            when "1"
              game = Game.new(Player::Human.new("X"), player_2=Player::Computer.new("O"), board=Board.new.tap{|b| b.cells})
              game.board.display
              game.play

            when "2"
              game = Game.new(Player::Human.new("X"), player_2=Player::Human.new("O"), board=Board.new.tap{|b| b.cells})
              game.board.display
              game.play

            when "auto"
              game = Game.new(Player::Computer.new("X"), player_2=Player::Computer.new("O"), board=Board.new.tap{|b| b.cells})
              game.board.display
              game.play

            end
          end
      when "q" then abort
    end

  end

end
