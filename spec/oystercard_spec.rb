require 'oystercard'

describe Oystercard do
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

end
