require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Curriculum Ratings', type: :system) do
  let(:user) { create(:user) }
  let(:lesson_json) { File.new('spec/support/curriculum/responses/lesson.json').read }

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    stub_a_valid_request(lesson_json)

    visit curriculum_key_stage_unit_lesson_path(key_stage_slug: 'key-stage-3',
                                                unit_slug: 'representations-from-clay-to-silicon', lesson_slug: 'lesson-1-across-time-and-space')
  end

  context 'when logged in', js: true do
    before do
      stub_a_rating_request('bbc0e7c9-2abe-49c6-9593-358794905563')
    end

    it 'shows the ratings box with the expected text' do
      expect(page).to have_css('.curriculum__rating', text: 'Did you find these resources useful?')
    end

    describe 'when a negative rating is given' do
      before do
        click_on class: 'curriculum__rating--thumb-down'
      end

      it 'does not show the thumbs buttons' do
        expect(page).not_to have_css('.curriculum__rating--thumb-up')
        expect(page).not_to have_css('.curriculum__rating--thumb-down')
      end

      it 'shows the expected text' do
        expect(page).to have_css('.curriculum__rating--text', text: 'Thanks for your rating!')
      end

      it 'shows a textarea' do
        expect(page).to have_css('.curriculum__rating-textarea')
      end
    end

    describe 'when a reason is given for a negative rating' do
      before do
        click_on class: 'curriculum__rating--thumb-down'
        fill_in id: 'comment', with: 'No, I just came here to criticise'
        click_on 'Submit'
      end

      it 'does not show the textarea' do
        expect(page).not_to have_css('.curriculum__rating-textarea')
      end

      it 'shows the expected text' do
        expect(page).to have_css('.curriculum__rating--text-only', text: 'Thanks for your feedback!')
      end
    end

    describe 'when a positive rating is given' do
      before do
        click_on class: 'curriculum__rating--thumb-up'
      end

      it 'does not show the thumbs buttons' do
        expect(page).not_to have_css('.curriculum__rating--thumb-up')
        expect(page).not_to have_css('.curriculum__rating--thumb-down')
      end

      it 'shows the textarea' do
        expect(page).to have_css('.curriculum__rating-textarea')
      end

      it 'shows the expected text' do
        expect(page).to have_css('.curriculum__rating--text', text: 'Thanks for your rating!')
      end
    end
  end
end
