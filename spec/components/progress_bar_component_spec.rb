require 'rails_helper'

RSpec.describe ProgressBarComponent, type: :component do
    let(:user) { create(:user) }
    let(:programme) { create(:primary_certificate) }
    let!(:primary_programme_activity_groupings) do
      create_list(:programme_activity_grouping, 4, programme: programme).tap do |groupings|
        groupings[0].update(title: 'All courses')
        groupings[1].update(title: 'Contribute to an online discussion')
        groupings[2].update(title: 'Develop your teaching practice')
        groupings[3].update(title: 'Develop computing in your community')
      end
    end

    let!(:secondary_rogramme_activity_groupings) do
      create_list(:programme_activity_grouping, 4, programme: programme).tap do |groupings|
        groupings[0].update(title: 'All courses')
        groupings[1].update(title: 'Develop your subject knowledge')
        groupings[2].update(title: 'Develop your teaching practice')
        groupings[3].update(title: 'Develop computing in your community')
      end
    end
  
    before(:each) do 
      render_inline(described_class.new(user, programme))
    end 
  
    it 'has a title' do
      expect(page).to have_css('h4', text: 'Your certificate progress')
    end 
  
    it 'has a description' do
      expect(page).to have_css('.ncce-progress-section--description', count: 1)
    end 
    
    context "when primary certificate" do
      it 'has 3 completion steps' do
          expect(rendered_component).to have_css('.ncce-progress-section') do
              expect(rendered_component).to have_css('.ncce-progress-section--text', text: 'Contribute to an online discussion')
              expect(rendered_component).to have_css('.ncce-progress-section--text', text: 'Develop your teaching practice')
              expect(rendered_component).to have_css('.ncce-progress-section--text', text: 'Develop computing in your community')
            end
      end 
    end

    context "when se certificate" do
      it 'has 3 completion steps' do
          expect(rendered_component).to have_css('.ncce-progress-section') do
              expect(rendered_component).to have_css('.ncce-progress-section--text', text: 'Develop your subject knowledge')
              expect(rendered_component).to have_css('.ncce-progress-section--text', text: 'Develop your teaching practice')
              expect(rendered_component).to have_css('.ncce-progress-section--text', text: 'Develop computing in your community')
            end
      end 
    end
    
  end
  