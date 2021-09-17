describe Robot do
  before do
    subject.set_tabletop_dimensions(5,5)
  end

  describe '#place' do
    it 'allows to place the robot within limits' do
      expect(subject.place([0,0], 'NORTH')).to be true
      expect(subject.place([4,4], 'NORTH')).to be true
    end

    it 'does not place the robot off limits' do
      expect(subject.place([5,5], 'NORTH')).to be false
      expect(subject.place([-1,0], 'NORTH')).to be false
    end
  end

  describe '#next_position' do
    shared_examples 'movement' do |position, face, next_position|
      context "when at #{position} and facing #{face}" do
        before do
          subject.place(position, face)
        end
        it "heads to #{next_position}" do
          expect(subject.next_position).to eq next_position
        end
      end
    end

    # checking 2 corners should be enough
    it_behaves_like 'movement', [0,0], 'NORTH', [0,1]
    it_behaves_like 'movement', [0,0], 'EAST', [1,0]
    it_behaves_like 'movement', [0,0], 'WEST', [-1,0]
    it_behaves_like 'movement', [0,0], 'SOUTH', [0,-1]
    it_behaves_like 'movement', [4,4], 'NORTH', [4,5]
    it_behaves_like 'movement', [4,4], 'EAST', [5,4]
    it_behaves_like 'movement', [4,4], 'WEST', [3,4]
    it_behaves_like 'movement', [4,4], 'SOUTH', [4,3]
  end

  describe '#move' do
    shared_examples 'step' do |position, face, next_position|
      context "when at #{position} and facing #{face}" do
        before do
          subject.place(position, face)
        end
        it "next position is #{next_position}" do
          subject.move
          expect(subject.position).to eq next_position
        end
      end
    end

    it_behaves_like 'step', [0,0], 'NORTH', [0,1]
    it_behaves_like 'step', [0,0], 'EAST', [1,0]
    it_behaves_like 'step', [0,0], 'WEST', [0,0]
    it_behaves_like 'step', [0,0], 'SOUTH', [0,0]
    it_behaves_like 'step', [4,4], 'NORTH', [4,4]
    it_behaves_like 'step', [4,4], 'EAST', [4,4]
    it_behaves_like 'step', [4,4], 'WEST', [3,4]
    it_behaves_like 'step', [4,4], 'SOUTH', [4,3]

  end

  describe '#turn' do
    before do
      subject.place([0,0], 'NORTH')
    end
    shared_examples "rotation" do |face, direction, new_face|
      context "when facing #{face} and turning #{direction}" do
        before { subject.set_face(face) }
        it "now faces #{new_face}" do
          subject.turn(direction)
          expect(subject.face).to eq new_face
        end
      end
    end

    it_behaves_like 'rotation', 'NORTH', 'LEFT', 'WEST'
    it_behaves_like 'rotation', 'NORTH', 'RIGHT', 'EAST'
    it_behaves_like 'rotation', 'WEST', 'LEFT', 'SOUTH'
    it_behaves_like 'rotation', 'WEST', 'RIGHT', 'NORTH'
    it_behaves_like 'rotation', 'SOUTH', 'LEFT', 'EAST'
    it_behaves_like 'rotation', 'SOUTH', 'RIGHT', 'WEST'
    it_behaves_like 'rotation', 'EAST', 'LEFT', 'NORTH'
    it_behaves_like 'rotation', 'EAST', 'RIGHT', 'SOUTH'
  end

end
