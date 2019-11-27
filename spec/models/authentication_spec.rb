describe JsonWebToken do
  subject { described_class }

  let(:payload) { { 'one' => 'two' } }
  let(:token) { '...' }

  describe '.encode' do
    it { expect(subject.encode(payload)).to eq(token) }
  end

  describe '.decode' do
    it { expect(subject.decode(token)).to eq(payload) }
  end
end
