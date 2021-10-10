require 'rspec'

describe 'searching missing fields' do
	subject(:client) { Elasticsearch::Client.new url: 'http://localhost:19200', log: true }

  RSpec::Matchers.define :find_object do |expected|
    match do |actual|
      hits = actual["hits"]


      if hits['hits'].size > 0
        hits['hits'].find { |hit| hit['_id'].to_s == expected.to_s } != nil
      end
    end
  end

	describe '#cluster' do
		subject { client.cluster.health }

		it { is_expected.to include('cluster_name' => 'c1') }
	end

  describe '#get' do
    
  end

	describe '#search' do
		let(:index_name) { 'test_index' }
		subject { client.search body: query.to_hash }

		before do
			client.indices.delete index: index_name, ignore: 404

			client.indices.create(index: index_name)

			response = client.indices.put_mapping(
				index: index_name,
				body: {
					properties: {
						name: {
							type: 'text'
						},
            lang: {
              type: 'keyword'
            }
					}
				}
			)
		end

		context 'searching missing fields', focus: true do
			before do
        client.index(
            index: index_name,
            id: 1,
            body: {
              name: 'Giorgenes Gelatti'
            }
          )
      end

      let(:query) do
        search do
          query do
            bool do
              must_not do
                exists field: 'lang'
              end
            end
          end
        end
      end

      it { is_expected.to find_object(1) }
		end
	end
end