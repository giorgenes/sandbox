describe Cli do
  let(:db) { instance_double('Database') }
  let(:cli) { described_class.new(args, db) }
  let(:args) { [] }

  before do
    allow(db).to receive(:term).and_return(nil)
    allow(db).to receive(:prefix).and_return([])
    allow(db).to receive(:dups).and_return([])
  end

  describe '#help' do
    it 'prints the help message' do
      expect { cli.help }.to output(/Usage: cli \[command\] \[options\]/).to_stdout
      expect { cli.help }.to output(/Available commands:/).to_stdout
      expect { cli.help }.to output(/search: Search by name/).to_stdout
      expect { cli.help }.to output(/find_dups: Find duplicate emails in the loaded data/).to_stdout
    end
  end

  describe '#run' do
    context 'when no arguments are provided' do
      it 'prints the help message' do
        expect { cli.run }.to output(/Usage: cli \[command\] \[options\]/).to_stdout
      end
    end

    context 'when an invalid command is provided' do
      let(:args) { ['invalid_command'] }

      it 'prints the help message' do
        expect { cli.run }.to output(/Usage: cli \[command\] \[options\]/).to_stdout
      end
    end

    context 'when a valid command is provided' do
      let(:args) { ['search', 'John'] }

      it 'calls the search method with the correct arguments' do
        expect(cli).to receive(:search).with(['John'])

        cli.run
      end

      context 'when find_dups command is provided' do
        let(:args) { ['find_dups'] }

        it 'calls the find_dups method' do
          expect(cli).to receive(:find_dups)

          cli.run
        end
      end
    end
  end

  describe '#search' do
    let(:args) { ['search', 'John'] }

    it 'prints the search query' do
      expect { cli.search(['John']) }.to output(/Searching for: John/).to_stdout
    end
  end

  describe '#find_dups' do
    it 'prints finding duplicates message' do
      expect { cli.find_dups }.to output(/Finding duplicates.../).to_stdout
    end
  end
end