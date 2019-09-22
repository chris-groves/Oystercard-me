class Oystercard

  BALANCE_LIMIT = 90

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Error: balance will exceed £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end


end
