require 'oystercard'

describe Oystercard do
  before(:each) do
    @card = Oystercard.new
    @card.top_up(Oystercard::MINIMUM_FARE)
  end

  it 'allows the customer to touch in and pass through the barriers' do
    expect(@card).to respond_to(:touch_in).with(1).argument
  end

  describe '#balance' do
    it 'default balance is zero' do
      expect(subject.balance).to eq Oystercard::START_BALANCE
    end
  end

  describe '#top_up' do
    it 'Responds to top_up method' do
      expect(@card).to respond_to(:top_up)
    end

    it 'Balance should change when topped up' do
      expect(@card.top_up(5)).to eq(6)
    end

    it 'Error msg raised when max balance reached' do
      expect { @card.top_up(Oystercard::MAX_BALANCE) }.to raise_error('Max balance reached')
    end
  end

  # describe '#deduct' do
  #     it 'responds to deduct method' do
  #         expect(@card).to respond_to(:deduct)
  #     end
  #
  #     it 'balance should change when deducted' do
  #         expect(@card.deduct(Oystercard::MINIMUM_FARE)).to eq(0)
  #     end
  # end
  #

  describe '#touch_in' do
    it 'raises an error if balance is below minimum fare' do
      expect { subject.touch_in('Pimlico') }.to raise_error 'Insufficient funds'
    end

    it 'stores the entry station' do
      expect(@card.touch_in('Pimlico')).to eq 'Pimlico' # have_attributes(entry_station: "Pimlico")
    end

    it 'card is in journey' do
      @card.touch_in('Pimlico')
      expect(@card).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'deducts the minimum fare at the end of the journey' do
      @card.touch_out
      expect(@card.balance).to eq(0)
    end

    it 'it shows that you are no longer in the entry station' do
      @card.touch_in('Pimlico')
      expect(@card.touch_out).to be nil
    end
  end
end
