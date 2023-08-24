require 'rails_helper'

RSpec.describe PathwayImprovementsComponent, type: :component do
  let(:pathway) { create(:pathway) }

  before do
    render_inline(described_class.new(pathway:))
  end

  context 'when improvement copy is not part of the pathway' do
    it 'should not render' do
      expect(page).to have_no_selector('body')
    end
  end

  context 'when the pathway has improvement copy' do
    let(:pathway) { create(:pathway, improvement_bullets: ['test1', 'test2', 'test3'], improvement_cta: 'Click me!') }

    it 'renders the title' do
      expect(page).to have_text('Teachers following this pathway will contribute to improving:')
    end

    it 'has an improvement cta' do
      expect(page).to have_selector('p.govuk-body-s', text: 'Click me!')
    end

    it 'has improvement bullets' do
      expect(page).to have_selector('li', text: 'test1')
      expect(page).to have_selector('li', text: 'test2')
      expect(page).to have_selector('li', text: 'test3')
    end
  end
end
