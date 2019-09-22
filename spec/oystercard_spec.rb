require 'oystercard'

describe Oystercard do
  it 'has an initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'can be topped up' do
    expect { subject.top_up(5) }.to change { subject.balance }.by(5)
  end

end
