require 'rails_helper'

RSpec.describe('programmes/certificate/_cs-accelerator', type: :view) do
  let!(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  # let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    # assessment
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @programme = programme
    render
  end

  it 'has programme name' do
    expect(rendered).to have_css('h1', text: programme.title)
  end

end
