require_relative "../lib/cell"

describe Cell do
  describe "#occupied?" do
    context "when occupied by a nought" do
      subject(:cell_nought) { described_class.new(PlayingPieces::NOUGHT) }

      it "returns true" do
        expect(cell_nought.occupied?).to be(true)
      end
    end

    context "when occupied by a cross" do
      subject(:cell_cross) { described_class.new(PlayingPieces::CROSS) }

      it "returns true" do
        expect(cell_cross.occupied?).to be(true)
      end
    end

    context "when not occupied by a playing piece" do
      subject(:cell_available) { described_class.new(1) }

      it "returns false" do
        expect(cell_available.occupied?).to be(false)
      end
    end
  end

  describe "#update" do
    context "when updating value from an integer to a nought" do
      subject(:cell_nine) { described_class.new(9) }

      let(:new_value) { PlayingPieces::NOUGHT }

      it "updates value to a nought" do
        cell_nine.update(new_value)
        expect(cell_nine.value).to eq(new_value)
      end

      it "returns a nought" do
        result = cell_nine.update(new_value)
        expect(result).to eq(new_value)
      end
    end

    context "when updating value from an integer to a cross" do
      subject(:cell_one) { described_class.new(1) }

      let(:new_value) { PlayingPieces::CROSS }

      it "updates value to a cross" do
        cell_one.update(new_value)
        expect(cell_one.value).to eq(new_value)
      end

      it "returns a cross" do
        result = cell_one.update(new_value)
        expect(result).to eq(new_value)
      end
    end
  end
end
