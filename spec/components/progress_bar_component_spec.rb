require 'rails_helper'

RSpec.describe ProgressBarComponent, type: :component do
    let(:user) { create(:user) }
    let(:programme) { create(:primary_certificate) }
  
    before(:each) do 
      render_inline(described_class.new(user, programme))
    end 
  
    it 'has a title' do
      expect(page).to have_css('h4', text: 'Your certificate progress')
    end 
  
    it 'has a description' do
      expect(page).to have_css('.ncce-progress-section--description', count: 1)
    end 
  
    it 'has 3 completion steps' do
      expect(page).to have_css('.ncce-progress-section--text', count: 3)
    end 
  
    context 'when programme is "Teach primary computing"' do
      it 'displays correct completion steps' do
        render_inline(described_class.new(user, programme))
        expect(page).to have_css('.ncce-progress-section--text', text: "Contribute to an online discussion")
        expect(page).to have_css('.ncce-progress-section--text', text: "Develop your teaching practice")
        expect(page).to have_css('.ncce-progress-section--text', text: "Develop computing in your community")
      end
    end
  end
  