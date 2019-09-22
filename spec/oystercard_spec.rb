require 'oystercard'

describe Oystercard do

  let(:station){ double :station }
  let(:station_2){ double :station_2 }

  it 'has an initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'can be topped up' do
    expect { subject.top_up(5) }.to change { subject.balance }.by(5)
  end

  it 'has a maximum balance of 90' do
    subject.top_up(Oystercard::BALANCE_LIMIT)
    message = "Error: balance will exceed £#{Oystercard::BALANCE_LIMIT}"
    expect { subject.top_up(5) }.to raise_error message
  end

  it 'has an intial status of "not in journey"' do
    expect(subject.in_journey?).to eq false
  end

  it 'can touch into a journey' do
    subject.top_up(5)
    expect { subject.touch_in(station) }.to change { subject.in_journey? }.to(true)
  end

  it 'can touch out of a journey' do
    subject.top_up(5)
    subject.touch_in(station)
    expect { subject.touch_out(station_2) }.to change { subject.in_journey? }.to(false)
  end

  it 'prevents touch in if balance is less than minimum amount' do
    message = "Error: balance is below £#{Oystercard::MINIMUM_FARE}"
    expect { subject.touch_in(station) }.to raise_error message
  end

  it 'reduces balance on touch out' do
    expect { subject.touch_out(station_2) }.to change { subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it 'stores the entry station when touching in' do
    subject.top_up(5)
    expect { subject.touch_in(station) }.to change { subject.entry_station}.to(station)
  end

  it 'stores the exit station when touching out' do
    subject.top_up(5)
    subject.touch_in(station)
    expect { subject.touch_out(station_2) }.to change { subject.exit_station}.to(station_2)
  end

  it 'has an initial empty journey history' do
    expect(subject.journey_history).to eq([])
  end

  it 'touching in and out creates ones journey' do
    subject.top_up(5)
    subject.touch_in(station)
    subject.touch_out(station_2)
    expect(subject.latest_journey).to eq({:entry_station => station, :exit_station => station_2})
  end

end
