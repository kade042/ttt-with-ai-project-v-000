
class Human < Player
  def move(board)
    puts "\nPlayer #{self.token}'s turn"
    puts "Please enter 1-9:"
    input = gets.strip

    if board.is_a?(Array)
      input
    elsif !(board.valid_move?(input))
      puts "invalid"
      move(board)
    else
      board.update(input, self)
      input
    end
  end
end
