require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 5, programme_id: secondary_certificate.id) }

  before do
    FactoryBot.rewind_sequences
    cs_accelerator
    @current_user = user
    @programme = secondary_certificate
    programme_activity_groupings.each do |grouping|
      create_list(:programme_activity, 3, programme_id: @programme.id, programme_activity_grouping_id: grouping.id)
    end
    @programme_activity_groupings = @programme.programme_activity_groupings
    @user_programme_achievements = UserProgrammeAchievements.new(@programme, @current_user)
    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: @programme.title)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 4)
  end

  it 'has support information' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Support')
  end
end
