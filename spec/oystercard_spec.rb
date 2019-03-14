require 'oystercard'

describe Oystercard do
  let(:entry_station) { double('Picadilly') }
  let(:exit_station) { double('Pimlico') }
  let(:touch_out) { @card.touch_out(exit_station) }
  let(:touch_in) { @card.touch_in(entry_station) }

  before(:each) do
    @card = Oystercard.new
    @card.top_up(Oystercard::MINIMUM_FARE)
  end

  it 'allows the customer to touch in and pass through the barriers' do
    expect(@card).to respond_to(:touch_in).with(1).argument
  end

  it 'has empty list of journeys' do
    expect(subject.journeys).to be_empty
  end

  describe '#balance' do
    # balance = 0
    it 'default balance is zero' do
      expect(subject.balance).to eq Oystercard::START_BALANCE
    end
  end

  describe '#top_up' do
    it 'Responds to top_up method' do
      expect(@card).to respond_to(:top_up)
    end

    # balance = 0
    it 'Balance should change when topped up' do
      expect(@card.top_up(5)).to eq(6)
    end

    # balance = 0
    it 'Error msg raised when max balance reached' do
      expect { @card.top_up(Oystercard::MAX_BALANCE) }.to raise_error('Max balance reached')
    end
  end

  describe '#touch_in' do
    # balance = 0
    it 'raises an error if balance is below minimum fare' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds'
    end

    it 'stores the entry station' do
      expect(touch_in).to eq entry_station
    end

    it 'card is in journey' do
      expect(@card).not_to be_in_journey
    end
  end

  describe '#touch_out' do

    it 'deducts the minimum fare at the end of the journey' do
      touch_in
      expect { touch_out }.to change { @card.balance }.by -Oystercard::MINIMUM_FARE
    end

    it 'stores the exit station' do
      touch_out
      expect(@card.exit_station).to eq exit_station
    end

    it 'it shows that you are no longer in the entry station' do
      expect(touch_out).to be nil
    end

    it 'stores a journey' do
      touch_in
      touch_out

      expect(@card.view_trips[0].entry_station).to eq entry_station
    end
  end
end
