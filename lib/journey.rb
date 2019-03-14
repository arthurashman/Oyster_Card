class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 10

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil, station = Station)
    @station = station
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start_journey(entry_station)
    @entry_station = @station.new(entry_station)
  end

  def end_journey(exit_station)
    @exit_station = @station.new(exit_station)
  end

  def journey_complete?
    @entry_station && @exit_station ? true : false
  end

  def calculate_fare
    journey_complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
