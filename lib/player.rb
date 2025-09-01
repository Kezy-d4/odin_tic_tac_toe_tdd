# Represents a player
class Player
  attr_reader :playing_piece, :id, :active # no need to test #attr_reader

  # This constructor only sets instance variables. There's no need to test it.
  def initialize(name, playing_piece)
    @name = name
    @playing_piece = playing_piece
    @id = "#{name}(#{playing_piece})"
    @active = false
  end

  # incoming command: test the direct public side effects
  # incoming query: test the return value
  def activate
    @active = true
  end

  # incoming command: test the direct public side effects
  # incoming query: test the return value
  def deactivate
    @active = false
  end

  # contains only Ruby standard library methods: no need to test
  def input_cell
    gets.chomp.to_i # #to_i will convert any inconvertible string to zero
  end
end
