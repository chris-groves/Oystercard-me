require 'station'

describe Station do
  it 'has a name' do
    bank = Station.new("Bank", 1)
    expect(bank.name).to eq "Bank"
  end

  it 'has a zone' do
    bank = Station.new("Bank", 1)
    expect(bank.zone).to eq 1
  end

end
