require_relative "lib/game"

puts "Input a name for player1 who will play crosses:"
player1_name = gets.chomp

puts "Input a name for player2 who will play noughts:"
player2_name = gets.chomp

system("clear")

player1 = Player.new(player1_name, PlayingPieces::CROSS)
player2 = Player.new(player2_name, PlayingPieces::NOUGHT)
game = Game.new(Board.new, player1, player2)
game.play
