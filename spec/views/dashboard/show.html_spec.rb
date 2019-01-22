require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user: user)
    assign(:delegate_course_list, [])
    @achievements = user.achievements
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h2', text: 'Your Dashboard')
  end

  it 'has progress section' do
    expect(rendered).to have_css('h3', text: 'Your Progress')
  end

  it 'has a link to certification' do
    expect(rendered).to have_link('certification', href: '/certification')
  end

  it 'has an aside' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  it 'has a link to download the diagnostic tool' do
    expect(rendered).to have_css('a', text: 'diagnostic tool')
  end
end
