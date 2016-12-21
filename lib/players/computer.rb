#require 'lib/player'
class Computer < Player
  attr_reader :best_choice

  def move(board)
    puts "\nPlayer #{self.token}'s turn"
    min_max(board, self)
    board.update(best_choice, self)
    best_choice.to_s
  end

  def min_max(board, current_player)

      return score(board) if board.over?

      scores = {}
      available_spaces = []
      board.cells.each_with_index {|v, i| available_spaces << i+1 if v == " " }
      available_spaces.each do |space|
        # Copy board so we don't mess up original
        potential_board = board.dup
        potential_board.update(space, current_player)
        scores[space] = min_max(potential_board, switch(current_player))
      end

      @best_choice, best_score = best_move(current_player.token, scores)
      best_score
  end

    def best_move(piece, scores)
      if piece == "X"
        scores.max_by { |k, v| v }
      elsif piece == "O"
        scores.min_by { |k, v| v }
      end
    end

    def score(board)
      if board.winner == "X"
        return 10
      elsif board.winner == "O"
        return -10
      else
        return  0
      end
    end

    def switch(piece)
      piece.token == "X" ? (Player::Computer.new("O")) : (Player::Computer.new("X"))
    end

end
