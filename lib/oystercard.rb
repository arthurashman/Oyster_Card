require 'journey'

class Oystercard
  START_BALANCE = 0
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :journeys, :exit_station

  def initialize(balance = START_BALANCE, journey_class = Journey)
    @balance = balance
    @entry_station = nil
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    raise 'Max balance reached' if (amount + balance) > MAX_BALANCE

    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient funds' if @balance < MINIMUM_FARE

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    
    @exit_station = exit_station
    journey = @journey_class.new(@entry_station, @exit_station)
    @journeys << journey
    deduct(journey.calculate_fare)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def view_trips
    @journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
