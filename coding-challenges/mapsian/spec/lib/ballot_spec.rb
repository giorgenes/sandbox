require 'timecop'
require 'byebug'

describe Ballot do
  let(:input) do
    [
      # first ballot
      [0, 2],
      [0, 1],

      [1, 3],

      [2, 1],
      # second ballot
      [0, 2],
      [0, 1],

      [1, 2],
      [1, 1],

      [2, 1],
    ]
  end

  subject { Ballot.new(input) }

  it "works as expected" do
    expect(subject.score).to eq [1, 0, 2]
  end
end
