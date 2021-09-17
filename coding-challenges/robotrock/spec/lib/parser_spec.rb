describe Parser do
  subject { Parser.new(sample) }

  shared_examples 'sample output' do |sample, expected_output|
    context "sample #{sample}" do
      let(:sample) { load_sample(sample) }
      specify do
        expect(subject.execute(StringIO.new).string).to eq(expected_output)
      end
    end
  end

  it_behaves_like 'sample output', "01", "0,1,NORTH\n"
  it_behaves_like 'sample output', "02", "0,0,WEST\n"
  it_behaves_like 'sample output', "03", "3,3,NORTH\n"
  it_behaves_like 'sample output', "04", "3,3,NORTH\n"

  def load_sample(sample)
    File.open(File.expand_path("../../samples/#{sample}.txt", __FILE__))
  end
end
