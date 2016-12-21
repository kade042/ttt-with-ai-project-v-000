class Board

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5],
    [6,7,8], [0,3,6],
    [1,4,7], [2,5,8],
    [0,4,8], [6,4,2]
  ]

  attr_accessor :cells
  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(pos)
    @cells[pos.to_i - 1]
  end

  def full?
    !(@cells.include?(" "))
  end

  def turn_count
    @cells.count{|token| token == "X" || token == "O"}
  end

  def taken?(location)
    @cells[location.to_i-1] != " " && @cells[location.to_i-1] != ""
  end

  def valid_move?(position)
    position.to_i.between?(1,9) && !taken?(position)
  end

  def update(location, current_player )

    @cells[location.to_i-1] = current_player.token
  end

  def initialize_dup(other)
      super(other)
      @cells = other.cells.dup
  end

  #######################################################################
  def draw?
    (!won? && full?)
  end

  def over?
    draw? || won?
  end

  def winner
    if won?.is_a?(Array)
      won?.tap {|i| return cells[i[0]] }
    else
      return nil
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      if cells[combo[0]] == cells[combo[1]] && cells[combo[1]] == cells[combo[2]] &&
      taken?(combo[0].to_i+1)
        return combo
      end
    end
    false
  end

end
