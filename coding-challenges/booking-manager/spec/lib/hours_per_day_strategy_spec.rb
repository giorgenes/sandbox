describe HoursPerDayStrategy do
  subject(:strategy) { described_class.new(limit) }
  let(:limit) { 2 }

  describe '#evaluate' do
    let(:booking) { BookingRequest.new(Time.now, 3600, 'dave', 'rico') }
    subject { strategy.evaluate(booking) }

    context 'when the limit has been reached' do
      before do
        strategy.evaluate(booking)
        strategy.evaluate(booking)
      end

      it { is_expected.to be false }
    end

    context 'when the limit has NOT been reached' do
      it { is_expected.to be true }

      context 'with multiple visits across multiple days' do
        before do
          Timecop.freeze(Date.today - 2) do
            strategy.evaluate(BookingRequest.new(Time.now, 3600, 'dave', 'marco'))
            strategy.evaluate(BookingRequest.new(Time.now, 3600, 'dave', 'rico'))
          end

          Timecop.freeze(Date.today + 2) do
            strategy.evaluate(BookingRequest.new(Time.now, 3600, 'dave', 'john'))
          end
        end

        it { is_expected.to be true }
      end
    end
  end
end