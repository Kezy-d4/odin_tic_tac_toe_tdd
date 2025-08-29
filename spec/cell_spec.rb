require_relative "../lib/cell"

describe Cell do
  describe "#occupied" do
    context "when cell is occupied by a nought" do
      subject(:cell_nought) { described_class.new(PlayingPieces::NOUGHT) }

      it "returns true" do
        expect(cell_nought.occupied?).to be(true)
      end
    end

    context "when cell is occupied by a cross" do
      subject(:cell_cross) { described_class.new(PlayingPieces::CROSS) }

      it "returns true" do
        expect(cell_cross.occupied?).to be(true)
      end
    end

    context "when cell is not occupied by a playing piece" do
      subject(:cell_available) { described_class.new(1) }

      it "returns false" do
        expect(cell_available.occupied?).to be(false)
      end
    end
  end
end
