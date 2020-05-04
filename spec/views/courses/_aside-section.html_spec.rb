require 'rails_helper'

RSpec.describe('courses/_aside-section', type: :view) do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.all.first }
  let(:programme) { create(:programme) }

  before do
    stub_course_templates
    @course = course
  end

  describe 'when logged in' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    context 'when its an online course' do
      before do
        allow(course).to receive(:online_cpd).and_return(true)
        render partial: 'courses/aside-section'
      end

      it 'prompts the user to join the course' do
        expect(rendered).to have_css('.ncce-aside__title', text: 'Join this course')
      end

      it 'tells the user who is delivering the course' do
        expect(rendered).to have_css('.ncce-aside__text', text: 'You will be taken to the FutureLearn website to create an account and sign up for online courses. Please use the same email address so we can track your progress.')
      end
    end

    context 'when its a face to face course' do
      before do
        allow(course).to receive(:online_cpd).and_return(false)
        render partial: 'courses/aside-section'
      end

      it 'prompts the user to book the course' do
        expect(rendered).to have_css('.ncce-aside__title', text: 'Book this course')
      end

      it 'tells the user who is delivering the course' do
        expect(rendered).to have_css('.ncce-aside__text', text: 'You will be taken to the STEM Learning website to see further details and book.')
      end
    end
  end
end
