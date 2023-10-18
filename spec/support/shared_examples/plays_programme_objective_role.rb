RSpec.shared_examples 'plays programme objective role' do
  it 'should respond_to user_complete?' do
    expect(subject.respond_to?(:user_complete?)).to be true
  end

  it 'should respond_to objective_displayed_in?' do
    expect(subject.respond_to?(:objective_displayed_in?)).to be true
  end
end
