require_relative "cell"
require_relative "playing_pieces"

# Represents the TicTacToe board
class Board
  attr_reader :cells # no need to test #attr_reader

  # This constructor only sets instance variables. There's no need to test it.
  def initialize
    @rows = 3
    @columns = 3
    # For convenience, we create one additional cell so that we can ignore
    # index zero when accessing the cells. Each cell is initialized with an
    # integer value for ease of reference, but a cell is considered empty until
    # one of the playing pieces has been assigned to it.
    @cells = Array.new((@rows * @columns) + 1) { |index| Cell.new(index) }
  end

  # incoming query: test the return value
  def any_winning_line?(playing_piece)
    lines.any? do |line|
      line.all? { |cell| cell.value == playing_piece }
    end
  end

  # incoming query: test the return value
  def full?
    @cells[1..9].all?(&:occupied?)
  end

  # outgoing command: test that the message is sent
  def update_cell(index, playing_piece)
    @cells[index]&.update(playing_piece)
  end

  # incoming query: test the return value
  def cell_available?(index)
    return false unless index.between?(1, 9)

    !@cells[index].occupied?
  end

  # contains only #puts and #print: no need to test
  def render
    [top_row, middle_row, bottom_row].each do |row|
      row.each { |cell| print "[#{cell.value}]" }
      puts
    end
  end

  private

  # These methods don't need to be comprehensively tested, not even through the
  # public interface. They merely access instance variables and collect them
  # into arrays, so we can assume they are reliable. Thoroughly testing them
  # would be incredibly tedious for no good reason.
  def lines
    [top_row, middle_row, bottom_row, left_column, middle_column, right_column,
     top_left_to_bottom_right_diagonal, top_right_to_bottom_left_diagonal]
  end

  def top_row
    [@cells[1], @cells[2], @cells[3]]
  end

  def middle_row
    [@cells[4], @cells[5], @cells[6]]
  end

  def bottom_row
    [@cells[7], @cells[8], @cells[9]]
  end

  def left_column
    [@cells[1], @cells[4], @cells[7]]
  end

  def middle_column
    [@cells[2], @cells[5], @cells[8]]
  end

  def right_column
    [@cells[3], @cells[6], @cells[9]]
  end

  def top_left_to_bottom_right_diagonal
    [@cells[1], @cells[5], @cells[9]]
  end

  def top_right_to_bottom_left_diagonal
    [@cells[3], @cells[5], @cells[7]]
  end
end
