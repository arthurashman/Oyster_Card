require 'journey'

describe Journey do
  it { is_expected.to respond_to(:start_journey) }
  it { is_expected.to respond_to(:end_journey) }
  it { is_expected.to respond_to(:journey_complete?) }
  it { is_expected.to respond_to(:calculate_fare) }

  let(:entry_station) { double }
  let(:exit_station) { double }

  describe '#start_journey' do
    it 'starts a journey' do
      expect { subject.start_journey(entry_station) } .to change{ subject.entry_station }
    end

    it 'end a journey' do
      expect { subject.end_journey(exit_station) } .to change{ subject.exit_station }
    end

    describe ' completed journeys' do
      before do
        subject.start_journey(entry_station)
        subject.end_journey(exit_station)
      end

      it 'checks a completed journey' do
        expect(subject.journey_complete?).to be true
      end

      it 'returns minimum fare for completed journey' do
        expect(subject.calculate_fare).to eq Journey::MINIMUM_FARE
      end
    end

    describe 'incomplete journey' do
      before do
        subject.start_journey(entry_station)
      end

      it 'returns penalty fare for completed journey' do
        expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
      end

      it 'checks an incomplete journey' do
        expect(subject.journey_complete?).to be false
      end
    end
  end
end
