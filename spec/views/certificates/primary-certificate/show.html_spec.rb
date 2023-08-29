require 'rails_helper'

RSpec.describe('certificates/primary_certificate/show', type: :view) do
  let(:user) { create(:user) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:pathway) { create(:pathway, programme: primary_certificate, title: 'Developing', pdf_link: 'developing.pdf') }
  let(:pathway_2) { create(:pathway, programme: primary_certificate, title: 'Specialising', pdf_link: 'specialising.pdf') }
  let(:pathways) { [pathway, pathway_2] }
  let(:professional_development_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 1, programme: primary_certificate) }
  let(:online_development_group) { create(:programme_activity_grouping, :with_activities, sort_key: 3, community: true, programme: primary_certificate) }
  let(:community_groups) { create_list(:programme_activity_grouping, 2, :with_activities, sort_key: 4, community: true, programme: primary_certificate) }
  let(:community_activity) { create(:activity, :community) }

  before do
    assign(:programme, primary_certificate)
  end

  describe 'when the user has no pathway' do
    before do
      assign(:current_user, user)
      assign(:user_pathway, nil)

      assign(:face_to_face_achievements, [])
      assign(:online_achievements, [])

      assign(:professional_development_groups, professional_development_groups)
      assign(:online_discussion_activity, community_activity)
      assign(:community_groups, community_groups)

      assign(:pathways, pathways)

      render
    end

    it 'has the hero' do
      expect(rendered).to have_css('.hero__heading', text: primary_certificate.title)
    end

    it 'has correct list setup' do
      expect(rendered).to have_css('.ncce-activity-list--programme', count: 3)
    end

    it 'has an intro' do
      expect(rendered).to have_css('.govuk-body-m', text: 'These courses and activities')
    end

    it 'has a community activity component' do
      expect(rendered).to have_css('.community-activity-component')
    end

    it 'has the expected section titles' do
      expect(rendered).to have_text('Complete one full day face-to-face, remote or online course, or a combination of short courses that amounts to 6+ hours of professional development.')
      expect(rendered).to have_text('Choose at least one activity to A group name', count: 2)
    end

    it 'has no recommendation list' do
      expect(rendered).not_to have_css('.recommended-courses-wrapper', text: 'Courses based on your pathway')
    end

    it 'shows all activities' do
      expect(rendered).to have_css('.ncce-activity-list__item', count: 4)
    end

    it 'shows no hidden activity title' do
      expect(rendered).not_to have_text('View more activity options')
    end

    it 'has view all courses button' do
      expect(rendered).to have_link('View and book courses')
    end

    it 'has bursary information' do
      expect(rendered).to have_css('.bursary-component__title', text: 'Funding')
    end

    it 'has support information' do
      expect(rendered).to have_css('.aside-component__heading', text: 'Need some help?')
    end

    it 'has feedback form' do
      expect(rendered).to have_css('.feedback-component__heading', text: 'What can we do better?')
    end

    describe 'the pathway selector' do
      it 'shows the no pathway title' do
        expect(rendered).to have_css('.ncce-pathway-prompt', text: "You're not currently on a pathway")
      end

      it 'has the details expander' do
        expect(rendered).to have_css('.ncce-details__summary-text', text: 'Learn more and select a pathway')
      end

      it 'has a list of pathways' do
        expect(rendered).to have_link('Developing', href: 'developing.pdf', visible: :hidden)
        expect(rendered).to have_link('Specialising', href: 'specialising.pdf', visible: :hidden)
      end

      it 'has an select list' do
        expect(rendered).to have_css('.ncce-pathway-aside__select', visible: :hidden)
      end

      it 'has a button' do
        expect(rendered).to have_button('Select pathway', visible: :hidden)
      end
    end
  end

  describe 'when the user has a pathway' do
    before do
      assign(:current_user, user)

      assign(:face_to_face_achievements, [])
      assign(:online_achievements, [])

      assign(:professional_development_groups, professional_development_groups)
      assign(:online_discussion_activity, community_activity)
      assign(:community_groups, community_groups)

      upe = create(:user_programme_enrolment, user_id: user.id, programme_id: primary_certificate.id, pathway_id: pathway.id)
      recommended_activities = upe.pathway.pathway_activities
      assign(:recommended_activities, recommended_activities.filter { |pa| pa.activity.category != :community.to_s })
      assign(:recommended_community_activities, recommended_activities.filter { |pa| pa.activity.category == :community.to_s })
      assign(:user_pathway, upe.pathway)
      assign(:pathways, pathways)
      assign(:available_pathways_for_user, [pathways[1]])
      render
    end

    it 'has a recommendation list' do
      expect(rendered).to have_css('.recommended-courses-wrapper .expander__button', text: 'Courses based on your pathway')
    end

    it 'has hidden activities' do
      expect(rendered).not_to have_text('View more activity options')
    end

    describe 'the pathway selector' do
      it 'shows the current pathway' do
        expect(rendered).to have_css('.ncce-pathway-prompt', text: 'Developing (PDF)')
      end

      it 'has the details expander' do
        expect(rendered).to have_css('.ncce-details__summary-text', text: 'Not sure this is the right pathway for you?')
      end

      it 'has a list of pathways' do
        expect(rendered).to have_link('Specialising', href: 'specialising.pdf', visible: :hidden)
      end

      it 'has an select list' do
        expect(rendered).to have_css('.ncce-pathway-aside__select', visible: :hidden)
      end

      it 'has a button' do
        expect(rendered).to have_button('Change pathway', visible: :hidden)
      end
    end
  end
end
