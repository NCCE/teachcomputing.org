require 'rails_helper'

RSpec.describe CommunityActivityComponent, type: :component do
  let(:activity) { create(:activity, :community) }
  let(:bookable_community_activity) { create(:activity, :community_bookable) }
  let(:incomplete_achievement) { create(:achievement, :community) }
  let(:completed_achievement) { create(:completed_achievement) }

  describe 'with an incomplete achievement' do
    before do
      render_inline(
        described_class.new(
          achievement: incomplete_achievement,
          activity:,
          class_name: 'custom_css_class',
          tracking_category: 'some category'
        )
      )
    end

    it 'does not render the complete class' do
      expect(page).not_to have_css('.community-activity-component__objective-text--complete')
    end

    it 'renders with the expected objective' do
      expect(page).to have_css('.community-activity-component__objective-text', text: 'Community Activity')
    end

    it 'renders the evidence button' do
      expect(page).to have_button('Submit evidence')
    end

    it 'has the buttons to self verify' do
      expect(page).to have_css('.ihavedonethis__button', count: 1)
    end

    it 'has different ids for each form\'s input' do
      expect(page).to have_field('self_verification_info', id: /#{activity.id}/)
    end

    it 'renders a description' do
      expect(page).to have_css('.community-activity-component__description', text: 'this is a community activity')
    end

    it 'renders the custom class' do
      expect(page).to have_css('.custom_css_class')
    end

    it 'renders a booking link' do
      expect(page).not_to have_link('Book a course')
    end

    context 'with an activity with no self verification info' do
      let(:activity) { create(:activity, :community, self_verification_info: nil) }

      it 'does not render the complete class' do
        expect(page).not_to have_css('.community-activity-component__objective-text--complete')
      end

      it 'renders with the expected objective' do
        expect(page).to have_css('.community-activity-component__objective-text', text: 'Community Activity')
      end

      it 'renders the mark complete button' do
        expect(page).to have_button('Mark complete')
      end

      it 'renders a description' do
        expect(page).to have_css('.community-activity-component__description', text: 'this is a community activity')
      end

      it 'renders the custom class' do
        expect(page).to have_css('.custom_css_class')
      end

      it 'renders a booking link' do
        expect(page).not_to have_link('Book a course')
      end
    end
  end

  describe 'with a booking_programme_slug' do
    before do
      render_inline(
        described_class.new(
          achievement: incomplete_achievement,
          activity: bookable_community_activity,
          class_name: 'custom_css_class',
          tracking_category: 'some category'
        )
      )
    end

    it 'renders a booking link' do
      expect(page).to have_link('Book a course', href: '/courses?certificate=cs-accelerator')
    end
  end

  describe 'with a completed achievement' do
    before do
      render_inline(
        described_class.new(
          achievement: completed_achievement,
          activity: activity,
          class_name: 'custom_css_class',
          tracking_category: 'some category'
        )
      )
    end

    it 'renders the complete class' do
      expect(page).to have_css('.community-activity-component__completed-badge', text: 'Completed')
    end

    it 'does not render the evidence button' do
      expect(page).not_to have_button('Submit evidence')
    end
  end
end
