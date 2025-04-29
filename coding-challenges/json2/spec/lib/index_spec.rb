describe Index do
  let(:data) { ['Bcd', 'Abc', 'Cde'] }
  let(:data_accessor) { ->(i) { data[i] } }
  let(:index) { Index.new(data.size, data_accessor) }

  describe '#initialize' do
    it 'creates an index based on the provided data' do
      expect(index.instance_variable_get(:@index)).to eq([1, 0, 2])
    end
  end

  describe '#[]' do
    it 'returns the index of the element at the given position' do
      expect(index[0]).to eq(1)
      expect(index[1]).to eq(0)
      expect(index[2]).to eq(2)
    end
  end

  describe '#term' do
    it 'returns the index of the first element greater than or equal to the query' do
      expect(index.term('Abc')).to eq(0)
      expect(index.term('Bcd')).to eq(1)
      expect(index.term('Cde')).to eq(2)
      expect(index.term('D')).to be_nil
    end
  end

  describe '#prefix' do
    let(:data) { ['Alice', 'Bob', "Alonso"] }

    it 'returns the index of the first element with the given prefix' do
      expect(index.prefix('Al')).to eq([0, 2])
      expect(index.prefix('Bob')).to eq([1])
      expect(index.prefix('Alo')).to eq([2])
      expect(index.prefix('D')).to be_empty
    end
  end

  describe '#dups' do
    let(:data) { ['Alice', 'Bob', 'Alice'] }

    it 'returns the indices of duplicate elements' do
      expect(index.dups).to eq(['Alice'])
    end

    it 'returns an empty array if there are no duplicates' do
      data.pop
      expect(index.dups).to be_empty
    end
  end
end