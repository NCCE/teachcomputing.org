require 'rails_helper'

RSpec.describe('courses/index', type: :view) do
  before do
    stub_fetch_future_courses
    stub_approved_course_templates

    @achiever = Achiever.new
    @face_to_face_courses = @achiever.approvedCourseTemplates
    @face_to_face_course_occurrences = @achiever.fetchFutureCourses

    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Courses')
  end

  it 'has a link to download the diagnostic tool' do
    expect(rendered).to have_css('a', text: 'Download Diagnostic Tool PDF')
  end

  describe 'face to face courses' do
    it 'renders each of the course template titles' do
      @face_to_face_courses.each do |course|
        expect(rendered).to have_css('govuk-heading-s', text: course.title)
      end
    end
  end
end
