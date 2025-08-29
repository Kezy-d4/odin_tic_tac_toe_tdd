require_relative "playing_pieces"

# Represents a single cell on the TicTacToe board
class Cell
  include PlayingPieces

  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def occupied?
    playing_pieces = [NOUGHT, CROSS]
    playing_pieces.include?(@value)
  end
end
