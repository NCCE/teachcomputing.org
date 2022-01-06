require 'rails_helper'

RSpec.describe('certificates/primary_certificate_v2/show', type: :view) do
  let(:user) { create(:user) }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:pathway) { create(:pathway, programme: primary_certificate, title: 'Developing in the classroom') }
  let!(:pathways) { create_list(:pathway, 2, programme: primary_certificate) }
  let(:groupings) { create_list(:programme_activity_grouping, 5, programme_id: primary_certificate.id) }

  before do
    stub_feature_flags({ primary_redesign_enabled: true })
    FactoryBot.rewind_sequences

    assign(:programme, primary_certificate)
    assign(:current_user, user)
    groupings.each do |grouping|
      create_list(:programme_activity, 3, programme_id: primary_certificate.id, programme_activity_grouping_id: grouping.id)
    end

    assign(:programme_activity_groups_1_to_3, primary_certificate.programme_activity_groupings.where(sort_key: 1..2).order(:sort_key))
    assign(:programme_activity_group_3, primary_certificate.programme_activity_groupings.where(sort_key: 3)[0].programme_activities)
    assign(:programme_activity_groups_4_to_5, primary_certificate.programme_activity_groupings.where(sort_key: 4..5).order(:sort_key))

    assign(:user_programme_achievements, UserProgrammeAchievements.new(primary_certificate, user))
    assign(:pathways, pathways)
  end

  after do
    unstub_feature_flags
  end

  describe 'when the user has no pathway' do
    before do
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

    it 'has the expected section titles' do
      expect(rendered).to have_text('Complete at least one online course')
      expect(rendered).to have_text('Complete at least one face to face, or remote course')
      expect(rendered).to have_text('Choose at least one activity to A group name', count: 2)
    end

    it 'has no recommendation list' do
      expect(rendered).not_to have_css('.recommended-courses-wrapper', text: 'Courses based on your pathway')
    end

    it 'shows all activities' do
      expect(rendered).to have_css('.ncce-activity-list__item', count: 12)
    end

    it 'shows no hidden activity title' do
      expect(rendered).not_to have_css('.ncce-activity-list__item', text: 'View more activity options')
    end

    it 'has no toggles' do
      expect(rendered).not_to have_css('.expander')
    end

    it 'has view all courses button ' do
      expect(rendered).to have_link('View all certificate courses')
    end

    it 'has bursary information' do
      expect(rendered).to have_css('.bursary-component__title', text: 'Bursary support')
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
        expect(rendered).to have_link('Pathway 1', href: 'https://example.com/pdf-2-link.pdf', visible: :hidden)
        expect(rendered).to have_link('Pathway 2', href: 'https://example.com/pdf-3-link.pdf', visible: :hidden)
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
      upe = create(:user_programme_enrolment, user_id: user.id, programme_id: primary_certificate.id, pathway_id: pathway.id)
      recommended_activities = upe.pathway.pathway_activities
      assign(:recommended_activities, recommended_activities.filter { |pa| pa.activity.category != :community.to_s })
      assign(:recommended_community_activities, recommended_activities.filter { |pa| pa.activity.category == :community.to_s })
      assign(:user_pathway, upe.pathway)
      assign(:pathways, pathways)
      assign(:available_pathways_for_user, pathways)
      render
    end

    it 'has a recommendation list' do
      expect(rendered).to have_css('.recommended-courses-wrapper .expander__button', text: 'Courses based on your pathway')
    end

    it 'has the expected number of toggles' do
      expect(rendered).to have_css('.expander', count: 3)
    end

    describe 'the pathway selector' do
      it 'shows the current pathway' do
        expect(rendered).to have_css('.ncce-pathway-prompt', text: 'Developing in the classroom (PDF)')
      end

      it 'has the details expander' do
        expect(rendered).to have_css('.ncce-details__summary-text', text: 'Not sure this is the right pathway for you?')
      end

      it 'has a list of pathways' do
        expect(rendered).to have_link('Pathway 2', href: 'https://example.com/pdf-3-link.pdf', visible: :hidden)
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
