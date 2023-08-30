RSpec.shared_examples 'EnrichmentExamplelike' do
  it 'should be valid' do
    expect(subject).to be_valid
  end

  context 'when title is missing' do
    it 'should not be valid' do
      subject.title = nil

      expect(subject).to_not be_valid
    end
  end

  context 'when programme is missing' do
    it 'should not be valid' do
      subject.programme = nil

      expect(subject).to_not be_valid
    end
  end
end
