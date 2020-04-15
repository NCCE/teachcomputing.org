require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/10_hours/_aside', type: :view) do
  let(:user) { create(:user) }

  before do
    @programme = create(:cs_accelerator)
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  it 'prompts the user to continue their journey' do
    render
    expect(rendered).to have_text('Continue your journey towards feeling confident about teaching GCSE computer science. You can do as much training as you like as part of this programme.')
  end

  it 'renders a button to find a course' do
    render
    expect(rendered).to have_css('.button', text: 'Find a course')
  end

  it 'renders a link to contact support' do
    render
    expect(rendered).to have_link('info@teachcomputing.org', href: 'mailto:info@teachcomputing.org')
  end

  context 'when the user is ready to take the test' do
    before do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:enough_activites_for_test?).with(user).and_return(true)
      render
    end

    it 'is made aware that they can continue on with their journey' do
      expect(rendered).to have_text('If you’re not yet feeling confident about teaching GCSE computer science, continue your journey.')
    end
  end
end
