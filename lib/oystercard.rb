class Oystercard
  START_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station


  def initialize(balance = START_BALANCE)
    @balance = balance
    @journey = nil
    @entry_station = nil
  end

  def top_up(amount)
    fail 'Max balance reached' if (amount + balance) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = station
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @journey = false
    @entry_station = nil
  end

  def in_journey?
    @journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end


end
