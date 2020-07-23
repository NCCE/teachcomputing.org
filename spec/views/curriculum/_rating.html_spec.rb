require 'rails_helper'

RSpec.describe('curriculum/_rating', type: :view) do
  describe 'a lesson rating partial' do
    before do
      render partial: 'curriculum/rating', locals: { path: :curriculum_lesson_rating_path, id: 'an_id' }
    end

    it 'renders the thumbs up link with expected route' do
      expect(rendered).to have_link(nil, href: '/curriculum/rating/lessons/positive/an_id')
    end

    it 'renders the thumbs down link with expected route' do
      expect(rendered).to have_link(nil, href: '/curriculum/rating/lessons/negative/an_id')
    end
  end

  describe 'a unit rating partial' do
    before do
      render partial: 'curriculum/rating', locals: { path: :curriculum_unit_rating_path, id: 'an_id' }
    end

    it 'renders the thumbs up link with expected route' do
      expect(rendered).to have_link(nil, href: '/curriculum/rating/units/positive/an_id')
    end

    it 'renders the thumbs down link with expected route' do
      expect(rendered).to have_link(nil, href: '/curriculum/rating/units/negative/an_id')
    end
  end
end
