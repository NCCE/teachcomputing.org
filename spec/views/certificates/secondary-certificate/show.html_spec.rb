require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, programme: secondary_certificate) }

  before do
    assign(:current_user, user)
    assign(:programme, secondary_certificate)
    assign(:programme_activity_groupings, programme_activity_groupings)
    assign(:user_programme_achievements, UserProgrammeAchievements.new(secondary_certificate, user))

    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: secondary_certificate.title)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 3)
  end

  it 'has support information' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Support')
  end
end
