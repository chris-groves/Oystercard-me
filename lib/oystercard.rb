class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :latest_journey, :journey_history

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @latest_journey = {:entry_station => "", :exit_station => ""}
    @journey_history = []
  end

  def top_up(amount)
    raise "Error: balance will exceed £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Error: balance is below £#{MINIMUM_FARE}" if @balance < MINIMUM_FARE
    @entry_station = station
    @latest_journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
    @latest_journey[:exit_station] = station
    @journey_history << @latest_journey
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
