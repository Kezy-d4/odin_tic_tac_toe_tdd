require_relative "playing_pieces"

# Represents a single cell on the TicTacToe board
class Cell
  attr_reader :value # no need to test #attr_reader

  # This constructor only sets instance variables. There's no need to test it.
  def initialize(value)
    @value = value
  end

  # incoming query: test the return value
  def occupied?
    playing_pieces = [PlayingPieces::NOUGHT, PlayingPieces::CROSS]
    playing_pieces.include?(@value)
  end

  # incoming command: test the direct public side effects
  # incoming query: test the return value
  def update(new_value)
    @value = new_value
  end
end
