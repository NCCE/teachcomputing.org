require 'rails_helper'

RSpec.describe('programmes/cs-accelerator/10_hours/_activity-list', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }

  before do
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
  end

  context 'when the user has not done the diagnostic' do
    before do
      stub_template 'programmes/cs-accelerator/10_hours/_achievements.html.erb' => 'stub achievements'
      stub_template 'programmes/cs-accelerator/10_hours/_exam.html.erb' => 'stub exam'
      allow(programme).to receive(:user_completed_diagnostic?).and_return(false)
      render
    end

    it 'has the button' do
      expect(rendered).to have_css('.button--small', text: 'Take the quiz')
    end

  end

  context 'when the user has done the diagnostic' do
    before do
      stub_template 'programmes/cs-accelerator/10_hours/_achievements.html.erb' => 'stub achievements'
      stub_template 'programmes/cs-accelerator/10_hours/_exam.html.erb' => 'stub exam'
      allow(programme).to receive(:user_completed_diagnostic?).and_return(true)
      render
    end

    it 'has the link to take the test again' do
      expect(rendered).to have_css('.ncce-link', text: 'Take the quiz again')
    end

  end
end
