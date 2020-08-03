require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/_quiz', type: :view) do
  let(:user) { create(:user) }
  let(:diagostic_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  before do
    diagostic_activity
    programme.activities << diagostic_activity
    achievement.transition_to(:complete)
    allow_any_instance_of(Programme).to receive(:user_completed?).and_return(true)
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    render
  end

	it 'has the roa' do
    expect(rendered).to have_text('Take our quiz to assess your subject knowledge and identify areas for development')
  end

end
