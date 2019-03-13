require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}

  it 'allows the customer to touch in and pass through the barriers' do
    expect(card).to respond_to(:touch_in)
  end

  describe '#balance' do

      it 'default balance is zero' do
          expect(card.balance).to eq Oystercard::START_BALANCE
      end
  end

  describe '#top_up' do

      it 'Responds to top_up method' do
          expect(card).to respond_to(:top_up)
      end

      it 'Balance should change when topped up' do
          expect(card.top_up(5)).to eq(5)
      end

      it 'Error msg raised when max balance reached' do
          expect{ card.top_up(100) }.to raise_error('Max balance reached')
      end
  end



  describe '#deduct' do
      it 'responds to deduct method' do
          expect(card).to respond_to(:deduct)
      end

      it 'balance should change when deducted' do
          expect(card.deduct(2)).to eq(-2)
      end
  end

  describe '#in_journey?' do
    it 'returns true if oystercard is in journey' do
      card.touch_in
      expect(card).to be_in_journey
    end
    it 'returns false if oystercard is not in journey' do
      card.touch_in
      card.touch_out
      expect(card).to_not be_in_journey
    end
  end
end
