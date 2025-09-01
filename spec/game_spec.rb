require_relative "../lib/game"

describe Game do
  #rubocop: disable all
  let(:board) { double("board") }
  let(:player1) { double("player1") }
  let(:player2) { double("player2") }
  before do
    allow(player1).to receive(:playing_piece).and_return(PlayingPieces::CROSS)
    allow(player2).to receive(:playing_piece).and_return(PlayingPieces::NOUGHT)
  end
  #rubocop: enable all
  describe "#over?" do
    context "when player 1 is victorious" do
      subject(:game_player1) { described_class.new(board, player1, player2) }

      before do
        allow(board).to receive(:any_winning_line?).with(player1.playing_piece).and_return(true)
        allow(board).to receive(:any_winning_line?).with(player2.playing_piece).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it "returns true" do
        result = game_player1.over?
        expect(result).to be(true)
      end
    end

    context "when player 2 is victorious" do
      subject(:game_player2) { described_class.new(board, player1, player2) }

      before do
        allow(board).to receive(:any_winning_line?).with(player1.playing_piece).and_return(false)
        allow(board).to receive(:any_winning_line?).with(player2.playing_piece).and_return(true)
        allow(board).to receive(:full?).and_return(false)
      end

      it "returns true" do
        result = game_player2.over?
        expect(result).to be(true)
      end
    end

    context "when game ends in a draw" do
      subject(:game_draw) { described_class.new(board, player1, player2) }

      before do
        allow(board).to receive(:any_winning_line?).with(player1.playing_piece).and_return(false)
        allow(board).to receive(:any_winning_line?).with(player2.playing_piece).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it "returns true" do
        result = game_draw.over?
        expect(result).to be(true)
      end
    end

    context "when neither player is victorious and the game has not ended in a draw" do
      subject(:game_mid) { described_class.new(board, player1, player2) }

      before do
        allow(board).to receive(:any_winning_line?).with(player1.playing_piece).and_return(false)
        allow(board).to receive(:any_winning_line?).with(player2.playing_piece).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it "returns false" do
        result = game_mid.over?
        expect(result).to be(false)
      end
    end
  end

  describe "#draw?" do
    context "when board is full and neither player has won" do
      subject(:game_draw) { described_class.new(board, player1, player2) }

      before do
        allow(board).to receive(:any_winning_line?).with(player1.playing_piece).and_return(false)
        allow(board).to receive(:any_winning_line?).with(player2.playing_piece).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it "returns true" do
        result = game_draw.draw?
        expect(result).to be(true)
      end
    end

    context "when board is full, but a player has won" do
      subject(:game_full_win) { described_class.new(board, player1, player2) }

      before do
        allow(board).to receive(:any_winning_line?).with(player1.playing_piece).and_return(true)
        allow(board).to receive(:any_winning_line?).with(player2.playing_piece).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it "returns false" do
        result = game_full_win.draw?
        expect(result).to be(false)
      end
    end
  end

  describe "#activate_first_mover" do
    context "when player 1 is playing crosses and player 2 is playing noughts" do
      subject(:game_player1_active) { described_class.new(board, player1, player2) }

      before do
        allow(player1).to receive(:playing_piece).and_return(PlayingPieces::CROSS)
        allow(player2).to receive(:playing_piece).and_return(PlayingPieces::NOUGHT)
      end

      it "sends the activate message to player 1" do
        expect(player1).to receive(:activate) # rubocop:disable RSpec/MessageSpies
        game_player1_active.activate_first_mover
      end
    end

    context "when player 1 is playing noughts and player 2 is playing crosses" do
      subject(:game_player2_active) { described_class.new(board, player1, player2) }

      before do
        allow(player1).to receive(:playing_piece).and_return(PlayingPieces::NOUGHT)
        allow(player2).to receive(:playing_piece).and_return(PlayingPieces::CROSS)
      end

      it "sends the activate message to player 2" do
        expect(player2).to receive(:activate) # rubocop:disable RSpec/MessageSpies
        game_player2_active.activate_first_mover
      end
    end
  end

  describe "#switch_active_player" do
    context "when player 1 is active and player 2 is inactive" do
      subject(:game_switch_player2) { described_class.new(board, player1, player2) }

      before do
        allow(player1).to receive(:active).and_return(true)
        allow(player2).to receive(:active).and_return(false)
      end

      #rubocop: disable all
      it "sends the deactivate message to player 1 and the activate message to player 2" do
        expect(player1).to receive(:deactivate)
        expect(player2).to receive(:activate)
        game_switch_player2.switch_active_player
      end
      #rubocop: enable all
    end

    context "when player 1 is inactive and player 2 is active" do
      subject(:game_switch_player1) { described_class.new(board, player1, player2) }

      before do
        allow(player1).to receive(:active).and_return(false)
        allow(player2).to receive(:active).and_return(true)
      end

      # rubocop: disable all
      it "sends the activate message to player 1 and the deactivate message to player 2" do
        expect(player1).to receive(:activate)
        expect(player2).to receive(:deactivate)
        game_switch_player1.switch_active_player
      end
      # rubocop: enable all
    end
  end

  describe "#player_input" do
    subject(:game_input) { described_class.new(board, player1, player2) }

    let(:error_msg) { "Invalid input. Please try again:" }

    context "when input is valid" do
      before do
        input = 1
        allow(player1).to receive_messages(active: true, input_cell: input)
        allow(player2).to receive(:active).and_return(false)
        allow(board).to receive(:cell_available?).with(input).and_return(true)
      end

      it "ends loop and does not print error message" do
        allow($stdout).to receive(:puts).with(error_msg)
        game_input.player_input
        expect($stdout).not_to have_received(:puts).with(error_msg)
      end
    end

    context "when first input is invalid, then second input is valid" do
      before do
        invalid_input = 0
        valid_input = 1
        allow(player1).to receive(:active).and_return(true)
        allow(player1).to receive(:input_cell).and_return(invalid_input, valid_input)
        allow(player2).to receive(:active).and_return(false)
        allow(board).to receive(:cell_available?).with(invalid_input).and_return(false)
        allow(board).to receive(:cell_available?).with(valid_input).and_return(true)
      end

      it "prints error message once, then ends loop" do
        allow($stdout).to receive(:puts).with(error_msg)
        game_input.player_input
        expect($stdout).to have_received(:puts).with(error_msg).once
      end
    end
  end
end
