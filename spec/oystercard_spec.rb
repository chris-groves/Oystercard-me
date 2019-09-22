require 'oystercard'

describe Oystercard do

  let(:station){ double :station }

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
    expect { subject.touch_out }.to change { subject.in_journey? }.to(false)
  end

  it 'prevents touch in if balance is less than minimum amount' do
    message = "Error: balance is below £#{Oystercard::MINIMUM_FARE}"
    expect { subject.touch_in(station) }.to raise_error message
  end

  it 'reduces balance on touch out' do
    expect { subject.touch_out }.to change { subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it 'stores the entry station when touching in' do
    subject.top_up(5)
    expect { subject.touch_in(station) }.to change { subject.entry_station}.to(station)
  end
end
