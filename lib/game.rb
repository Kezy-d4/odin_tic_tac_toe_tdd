require_relative "board"
require_relative "player"
require_relative "playing_pieces"

# Represents and coordinates the overall game
class Game
  # This constructor only sets instance variables. There's no need to test it.
  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  # public script method: ensure the methods inside are tested
  def play
    puts "Let's play TicTacToe!"
    activate_first_mover
    turn until over?
    end_message
  end

  # public script method: ensure the methods inside are tested
  def turn
    puts "#{active_player.id}, it's your move! Choose your next cell by " \
         "inputting its number:"
    @board.render
    index = player_input
    @board.update_cell(index, active_player.playing_piece)
    switch_active_player
    system("clear")
  end

  # incoming query: test the return value
  def over?
    player1_wins? || player2_wins? || draw?
  end

  # incoming query: test the return value
  def draw?
    @board.full? && !player1_wins? && !player2_wins?
  end

  # outgoing query: no need to test
  def player1_wins?
    @board.any_winning_line?(@player1.playing_piece)
  end

  # outgoing query: no need to test
  def player2_wins?
    @board.any_winning_line?(@player2.playing_piece)
  end

  # outgoing command: test that the message is sent
  def activate_first_mover
    first_mover.activate
  end

  # outgoing query: no need to test
  def active_player
    players = [@player1, @player2]
    players.find { |player| player.active == true }
  end

  # outgoing command: test that the message is sent
  def switch_active_player
    players = [@player1, @player2]
    currently_active = players.find { |player| player.active == true }
    currently_inactive = players.find { |player| player.active == false }
    currently_active.deactivate
    currently_inactive.activate
  end

  # looping script: test the conditions of the loop
  def player_input
    loop do
      input = active_player.input_cell
      return input if @board.cell_available?(input)

      puts "Invalid input. Please try again:"
    end
  end

  # conditional #puts: no need to test
  def end_message
    if player1_wins?
      puts "#{@player1.id} wins!"
    elsif player2_wins?
      puts "#{@player2.id} wins!"
    else
      puts "It's a draw!"
    end
    @board.render
  end

  private

  # message to self: no need to test
  def first_mover
    players = [@player1, @player2]
    players.find { |player| player.playing_piece == PlayingPieces::CROSS }
  end
end
