RSpec.shared_examples 'plays programme objective progress bar role' do
  describe '#objective_displayed_in?(:progress_bar)' do
    it 'should return true' do
      expect(subject.objective_displayed_in?(:progress_bar)).to be true
    end
  end

  it 'should respond to progress_bar_title' do
    expect(subject.respond_to?(:progress_bar_title)).to be true
  end

  describe '#progress_bar_title' do
    it 'should return a string' do
      expect(subject.progress_bar_title).to be_a String
    end
  end

  it 'should respond to progress_bar_path' do
    expect(subject.respond_to?(:progress_bar_path)).to be true
  end

  describe '#progress_bar_path' do
    it 'should return a string' do
      expect(subject.progress_bar_path).to be_a String
    end
  end
end
