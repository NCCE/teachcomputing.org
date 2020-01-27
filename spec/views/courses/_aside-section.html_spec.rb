require 'rails_helper'

RSpec.describe('courses/_aside-section', type: :view) do
  let(:user) { create(:user) }
  let(:course) { instance_double('course', booking_url: 'test.com/course') }
  let(:programme) { create(:programme) }

  before do
    @course = course
  end

  context 'when user is not logged in' do
    before do
      render partial: 'courses/aside-section'
    end

    it 'prompts to sign up' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'Start this course')
    end

    it 'has the sign up button' do
      expect(rendered).to have_link('Create an account', href: /\/user\/register/)
    end
  end

  context 'when user has logged in' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      render partial: 'courses/aside-section'
    end

    it 'prompts to book' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'Book onto this course')
    end

    it 'shows the booking button' do
      expect(rendered).to have_link('Book course', href: course.booking_url)
    end

    it 'does not show programme information' do
      expect(rendered).not_to have_css('.ncce-aside__text', text: /This course is part of the/)
    end
  end

  context 'when user has enrolled the course' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      allow_any_instance_of(CoursesHelper)
        .to receive(:user_achievement_state).and_return(:enrolled)
      render partial: 'courses/aside-section'
    end

    it 'shows they are doing it' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'You are doing this course')
    end
  end

  context 'when user has finished the course' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      allow_any_instance_of(CoursesHelper)
        .to receive(:user_achievement_state).and_return(:complete)
      render partial: 'courses/aside-section'
    end

    it 'shows they have done it' do
      expect(rendered).to have_css('.ncce-aside__title', text: "You've done this course")
    end
  end

  context 'when has not enrolled on the programme' do
    before do
      @programme = programme
      allow(programme).to receive(:user_enrolled?).and_return(false)
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      allow_any_instance_of(CoursesHelper)
        .to receive(:user_achievement_state).and_return(:not_enrolled)
      render partial: 'courses/aside-section'
    end

    it 'shows programme information' do
      expect(rendered).to have_css('.ncce-aside__text', text: "This course is part of the #{programme.title} certificate")
    end

    it 'prompts to learn more' do
      expect(rendered).to have_link('Learn more', href: /#{programme.slug}/)
    end
  end
end
