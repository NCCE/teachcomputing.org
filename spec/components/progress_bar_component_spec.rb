require 'rails_helper'

RSpec.describe ProgressBarComponent, type: :component do
    let(:user) { create(:user) }
    let(:primary_certificate) { create(:primary_certificate) }
    let(:primary_programme_activity_groupings) do
      create_list(:programme_activity_grouping, 3, programme: primary_certificate).tap do |groupings|
        groupings[0].update(progress_bar_title: 'Complete professional development')
        groupings[1].update(progress_bar_title: 'Develop your teaching practice')
        groupings[2].update(progress_bar_title: 'Develop computing in your community')
      end
    end

    context "when primary certificate" do

      before(:each) do
        primary_programme_activity_groupings
        render_inline(described_class.new(user, primary_certificate))
      end

      it 'has a title' do
        expect(page).to have_css('h4', text: 'Your certificate progress')
      end

      it 'has a description' do
        expect(page).to have_css('.ncce-progress-section--description', count: 1)
      end

      it 'has 3 completion steps' do
        expect(page).to have_css('.ncce-progress-section') do
          expect(page).to have_css('.ncce-progress-section--text', text: 'Complete professional development')
          expect(page).to have_css('.ncce-progress-section--text', text: 'Develop your teaching practice')
          expect(page).to have_css('.ncce-progress-section--text', text: 'Develop computing in your community')
        end
      end
    end
  end

