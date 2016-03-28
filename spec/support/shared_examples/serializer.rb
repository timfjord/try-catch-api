shared_examples 'serializer with policy' do
  let(:user) { create :user }
  subject { described_class.new object, scope: user }

  describe '#createable' do
    it 'should be falsy for guest' do
      user.role = 'guest'
      expect(subject.createable).to eql false
    end

    it 'should be truthy for regular and admin' do
      ['admin', 'regular'].each do |role|
        user.role = role
        expect(subject.createable).to eql true
      end
    end
  end

  [:editable, :deleteable].each do |method|
    describe "##{method}" do
      it 'should be falsy for guest' do
        user.role = 'guest'
        expect(subject.send(method)).to eql false
      end

      it 'should be truthy for admin' do
        user.role = 'admin'
        expect(subject.send(method)).to eql true
      end

      it 'should be truthy for regular only if it his own content' do
        user.update_attributes role: 'regular'
        expect(subject.send(method)).to eql false

        object.update_attributes user: user
        expect(subject.send(method)).to eql true
      end
    end
  end
end
