require_relative "../lib/board"

describe Board do
  describe "#any_winning_line?" do
    context "when evaluating an empty board" do
      subject(:board_start) { described_class.new }

      it "returns false when checking for a nought victory" do
        result = board_start.any_winning_line?(PlayingPieces::NOUGHT)
        expect(result).to be(false)
      end

      it "returns false when checking for a cross victory" do
        result = board_start.any_winning_line?(PlayingPieces::CROSS)
        expect(result).to be(false)
      end
    end

    context "when evaluating a board mid-game with no victor" do
      subject(:board_mid) { described_class.new }

      before do
        board_mid.update_cell(1, PlayingPieces::NOUGHT)
        board_mid.update_cell(2, PlayingPieces::NOUGHT)
        board_mid.update_cell(8, PlayingPieces::CROSS)
        board_mid.update_cell(9, PlayingPieces::CROSS)
      end

      it "returns false when checking for a nought victory" do
        result = board_mid.any_winning_line?(PlayingPieces::NOUGHT)
        expect(result).to be(false)
      end

      it "returns false when checking for a cross victory" do
        result = board_mid.any_winning_line?(PlayingPieces::CROSS)
        expect(result).to be(false)
      end
    end

    context "when evaluating a board with a nought victor" do
      subject(:board_nought) { described_class.new }

      before do
        board_nought.update_cell(1, PlayingPieces::NOUGHT)
        board_nought.update_cell(2, PlayingPieces::NOUGHT)
        board_nought.update_cell(3, PlayingPieces::NOUGHT)
        board_nought.update_cell(4, PlayingPieces::CROSS)
        board_nought.update_cell(5, PlayingPieces::CROSS)
      end

      it "returns true when checking for a nought victory" do
        result = board_nought.any_winning_line?(PlayingPieces::NOUGHT)
        expect(result).to be(true)
      end

      it "returns false when checking for a cross victory" do
        result = board_nought.any_winning_line?(PlayingPieces::CROSS)
        expect(result).to be(false)
      end
    end

    context "when evaluating a board with a cross victor" do
      subject(:board_cross) { described_class.new }

      before do
        board_cross.update_cell(1, PlayingPieces::CROSS)
        board_cross.update_cell(2, PlayingPieces::CROSS)
        board_cross.update_cell(3, PlayingPieces::CROSS)
        board_cross.update_cell(4, PlayingPieces::NOUGHT)
        board_cross.update_cell(5, PlayingPieces::NOUGHT)
      end

      it "returns false when checking for a nought victory" do
        result = board_cross.any_winning_line?(PlayingPieces::NOUGHT)
        expect(result).to be(false)
      end

      it "returns true when checking for a cross victory" do
        result = board_cross.any_winning_line?(PlayingPieces::CROSS)
        expect(result).to be(true)
      end
    end
  end

  describe "#full?" do
    context "when evaluating an empty board" do
      subject(:board_start) { described_class.new }

      it "returns false" do
        result = board_start.full?
        expect(result).to be(false)
      end
    end

    context "when evaluating a board mid-game" do
      subject(:board_mid) { described_class.new }

      before do
        board_mid.update_cell(1, PlayingPieces::NOUGHT)
        board_mid.update_cell(2, PlayingPieces::CROSS)
      end

      it "returns false" do
        result = board_mid.full?
        expect(result).to be(false)
      end
    end

    context "when evaluating a full board" do
      subject(:board_end) { described_class.new }

      before do
        board_end.update_cell(1, PlayingPieces::NOUGHT)
        board_end.update_cell(2, PlayingPieces::NOUGHT)
        board_end.update_cell(3, PlayingPieces::NOUGHT)
        board_end.update_cell(4, PlayingPieces::NOUGHT)
        board_end.update_cell(5, PlayingPieces::NOUGHT)
        board_end.update_cell(6, PlayingPieces::CROSS)
        board_end.update_cell(7, PlayingPieces::CROSS)
        board_end.update_cell(8, PlayingPieces::CROSS)
        board_end.update_cell(9, PlayingPieces::CROSS)
      end

      it "returns true" do
        result = board_end.full?
        expect(result).to be(true)
      end
    end
  end

  describe "#update_cell" do
    context "when updating cell 1 to a nought" do
      subject(:board_update_nought) { described_class.new }

      it "sends the update message to cell 1" do
        allow(board_update_nought.cells[1]).to receive(:update)
        board_update_nought.update_cell(1, PlayingPieces::NOUGHT)
        expect(board_update_nought.cells[1]).to have_received(:update)
      end
    end

    context "when updating cell 9 to a cross" do
      subject(:board_update_cross) { described_class.new }

      it "sends the update message to cell 9" do
        allow(board_update_cross.cells[9]).to receive(:update)
        board_update_cross.update_cell(9, PlayingPieces::CROSS)
        expect(board_update_cross.cells[9]).to have_received(:update)
      end
    end
  end

  describe "#cell_available?" do
    context "when given index is outside of valid range" do
      subject(:board_invalid_index) { described_class.new }

      it "returns false when given index is 0" do
        index = 0
        result = board_invalid_index.cell_available?(index)
        expect(result).to be(false)
      end

      it "returns false when given index is 10" do
        index = 10
        result = board_invalid_index.cell_available?(index)
        expect(result).to be(false)
      end
    end

    context "when given index is within valid range, but cell at that index is occupied" do
      subject(:board_cell_occupied) { described_class.new }

      before do
        board_cell_occupied.update_cell(1, PlayingPieces::CROSS)
        board_cell_occupied.update_cell(9, PlayingPieces::NOUGHT)
      end

      it "returns false when given index is 1 and cell 1 is occupied" do
        index = 1
        result = board_cell_occupied.cell_available?(index)
        expect(result).to be(false)
      end

      it "returns false when given index is 9 and cell 9 is occupied" do
        index = 9
        result = board_cell_occupied.cell_available?(index)
        expect(result).to be(false)
      end
    end

    context "when given index is within valid range and cell at that index is available" do
      subject(:board_cell_available) { described_class.new }

      it "returns true when given index is 1 and cell 1 is available" do
        index = 1
        result = board_cell_available.cell_available?(index)
        expect(result).to be(true)
      end

      it "returns true when given index is 9 and cell 9 is available" do
        index = 9
        result = board_cell_available.cell_available?(index)
        expect(result).to be(true)
      end
    end
  end
end
