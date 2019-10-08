require 'rails_helper'

RSpec.describe('pages/certification/_hero', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  before do
    @programme = programme
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.certification-hero__heading', text: programme.title)
  end

  it 'has one notepad image' do
    expect(rendered).to have_css('.certification-hero__image', count: 1)
  end

  it 'doesn\'t show the enrolled tag' do
    expect(rendered).not_to have_css('.certification-hero__enrolled', count: 1)
  end

  context 'when the user logged in but not enrolled' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render
    end

    it 'doesn\'t show the enrolled tag' do
      expect(rendered).not_to have_css('.certification-hero__enrolled', count: 1)
    end
  end

  context 'when the user logged in but not enrolled' do
    before do
      user_programme_enrolment
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      render
    end

    it 'shows the enrolled tag' do
      expect(rendered).to have_css('.certification-hero__enrolled', count: 1)
    end
  end
end
