describe Database do
  let(:adapter) { instance_double('JsonAdapter') }
  let(:db) { described_class.new(adapter) }

  describe '#term' do
    let(:table_name) { :clients }
    let(:column_name) { :name }
    let(:query) { 'Alice' }
    let(:docs) { [{ "name" => 'Alice' }, { 'name' => 'Bob' }] }
    let(:data_accessor) { ->(i) { docs[i][column_name] } }  

    before do
      allow(adapter).to receive(:load_from).with(anything).and_return(docs)

      db.load_table(table_name, 'clients.json')
      db.create_index(table_name, column_name)
    end

    it 'returns the document that matches the query' do
      result = db.term(table_name, column_name, query)

      expect(result).to eq(docs[0])
    end

    it 'raises an error if the table does not exist' do
      expect { db.term(:non_existent_table, column_name, query) }.to raise_error("Table non_existent_table not found")
    end

    it 'raises an error if the index for the column does not exist' do
      expect { db.term(table_name, :non_existent_column, query) }.to raise_error("Index for column non_existent_column not found")
    end
  end
end
