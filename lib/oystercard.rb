class Oystercard
  START_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize(balance = START_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    raise 'Max balance reached' if (amount + balance) > MAX_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds' if @balance < MINIMUM_FARE

    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station ? true : false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
