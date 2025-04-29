describe JsonAdapter do
  let(:json_adapter) { JsonAdapter.new }
  let(:uri) { 'http://example.com/data.json' }
  let(:json_data) { '[{"name": "John"}, {"name": "Jane"}]' }

  before do
    allow(URI).to receive(:open).with(uri).and_yield(StringIO.new(json_data))
  end

  describe '#load_from' do
    subject { json_adapter.load_from(uri) }

    it 'loads JSON data from a URI' do
      subject

      expect(subject).to eq(JSON.parse(json_data))
    end

    it 'handles HTTP errors gracefully' do
      allow(URI).to receive(:open).with(uri).and_raise(OpenURI::HTTPError.new('404 Not Found', nil))
      expect { subject }.not_to raise_error
      expect(subject).to be_empty
    end
  end
end