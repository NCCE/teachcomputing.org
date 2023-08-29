require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:professional_development_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 1, programme: secondary_certificate) }
  let(:community_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, community: true, programme: secondary_certificate) }
  let(:pathway) { create(:pathway, programme: secondary_certificate, title: 'Developing', pdf_link: 'developing.pdf') }
  let(:pathway_2) { create(:pathway, programme: secondary_certificate, title: 'Specialising', pdf_link: 'specialising.pdf') }
  let(:pathways) { [pathway, pathway_2] }

  before do
    assign(:current_user, user)
    assign(:programme, secondary_certificate)
    assign(:face_to_face_achievements, [])
    assign(:online_achievements, [])
    assign(:professional_development_groups, professional_development_groups)
    assign(:community_groups, community_groups)

    upe = create(:user_programme_enrolment, user_id: user.id, programme_id: secondary_certificate.id, pathway_id: pathway.id)
    recommended_activities = upe.pathway.pathway_activities
    assign(:recommended_activities, recommended_activities.filter { |pa| pa.activity.category != :community.to_s })
    assign(:recommended_community_activities, recommended_activities.filter { |pa| pa.activity.category == :community.to_s })
    assign(:user_pathway, upe.pathway)
    assign(:pathways, pathways)
    assign(:available_pathways_for_user, pathways)

    render
  end

  it 'has the hero' do
    expect(rendered).to have_css('.hero__heading', text: secondary_certificate.title)
  end

  it 'has correct list setup' do
    expect(rendered).to have_css('.ncce-activity-list--programme', count: 3)
  end

  it 'has an intro' do
    expect(rendered).to have_css('.govuk-body-m', text: 'These courses and activities have been picked so you can develop')
  end

  it 'has the expected section titles' do
    expect(rendered).to have_text('Complete one full day face-to-face, remote or online course, or a combination of short courses that amounts to 6+ hours of professional development.')
    expect(rendered).to have_text('Choose at least one activity to a group name', count: 2)
  end

  it 'has view all courses button' do
    expect(rendered).to have_link('View more courses')
  end

  it 'shows all activities' do
    expect(rendered).to have_css('.ncce-activity-list__item', count: 2)
  end

  it 'has support information' do
    expect(rendered).to have_css('.aside-component__heading', text: 'Need some help?')
  end

  it 'has feedback form' do
    expect(rendered).to have_css('.feedback-component__heading', text: 'What can we do better?')
  end
end
