require 'rails_helper'

RSpec.describe('courses/index', type: :view) do
  let(:achiever) { Achiever.new }

  before do
    stub_fetch_future_courses
    stub_approved_course_templates

    @courses = achiever.approved_course_templates
    @course_occurrences = achiever.future_courses
  render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Courses')
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
    end

    it 'has a courses link' do
      expect(rendered).to have_link('Create an account / log in', href: '/login')
    end
  end

  describe 'courses' do
    it 'renders each of the course template titles' do
      @courses.each do |course|
        expect(rendered).to have_css('.govuk-heading-s', text: course.title)
      end
    end
  end
end
