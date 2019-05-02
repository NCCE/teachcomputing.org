require 'rails_helper'

RSpec.describe('programmes/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }

  before do
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: @programme.title)
  end

  it 'has progress section' do
    expect(rendered).to have_css('h2', text: 'Your progress')
  end
end
