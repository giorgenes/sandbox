describe VisitingHoursStrategy do
  let(:from) { 8 }
  let(:to) { 12 }
  let(:time) { Time.now }
  let(:duration) { 600 }
  subject(:strategy) { described_class.new(from: from, to: to) }

  describe '#evaluate' do
    let(:booking) { BookingRequest.new(time, duration, 'dave', 'rico') }
    subject { strategy.evaluate(booking) }

    context 'when its outside visiting hours' do
      let(:time) { Time.new(2002, 10, 31, 2, 0, 0, "+02:00") }
      it { is_expected.to be false }
    end

    context 'when its inside visiting hours' do
      let(:time) { Time.new(2002, 10, 31, 9, 0, 0, "+02:00") }
      it { is_expected.to be true }

      context 'when the duration exceeds the visiting hours' do
        let(:duration) { 60 * 60 * 4 }

        it { is_expected.to be false }
      end
    end
  end
end