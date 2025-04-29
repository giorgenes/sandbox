require 'timecop'
require 'byebug'

describe BookingManager do
  subject(:manager) { BookingManager.new }

  describe '#evaluate' do
    subject { manager.evaluate(booking_requests) }

    let(:booking_requests) do
      [
        ["2023-03-02T09:19:29Z", "1:45", "Michael Chapman", "Jane Jones"],
        ["2023-03-02T09:19:29Z", "0:30", "Lydia Shafer", "Jane Jones"],
        ["2023-03-02T09:19:29Z", "2:25", "Nicholas Bruning", "John Smith"],
      ]
    end

    describe 'with no strategies' do
      it 'returns an empty deny list' do
        expect(subject).to eq([])
      end
    end

    describe 'with strategies' do
      let(:strategy) do
        double('strategy')
      end

      before do
        manager.add_strategy(strategy)
        allow(strategy).to receive(:evaluate).with(instance_of(BookingRequest)).and_return(true)
      end

      it 'runs the requests through the strategies' do
        expect(strategy).to receive(:evaluate).with(instance_of(BookingRequest)).exactly(3).times

        subject
      end

      context 'parsing the requests' do
        let(:booking_requests) do
          [["2023-03-02T09:19:29Z", "1:45", "Michael Chapman", "Jane Jones"]]
        end

        let(:expected_request) do
          BookingRequest.new(Time.parse("2023-03-02T09:19:29Z"), 6300, "Michael Chapman", "Jane Jones")
        end

        it 'translates the array input into BookingRequest' do
          expect(strategy).to receive(:evaluate).with(expected_request).exactly(1).times

          subject
        end
      end

      context 'with rejecting strategies' do
        class DummyStragegy
          def evaluate(booking)
            # Rejects Lydia
            booking.visitor != "Lydia Shafer"
          end
        end

        before do
          manager.add_strategy(DummyStragegy.new)
        end

        it 'returns a list of rejected visitors' do
          expect(subject).to eq(['Lydia Shafer'])
        end
      end
    end
  end
end
