require 'station'

describe Station do

  subject { Station.new("Highgate", 3) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:zone) }


end
