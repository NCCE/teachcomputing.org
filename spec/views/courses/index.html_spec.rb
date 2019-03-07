require 'rails_helper'

RSpec.describe('courses/index', type: :view) do
  let(:achiever) { Achiever.new }

  before do
    stub_fetch_future_courses
    stub_approved_face_to_face_course_templates
    stub_approved_online_course_templates
    stub_course_template_subject_details
    stub_course_template_age_range
    face_to_face_courses = achiever.approved_face_to_face_course_templates
    online_courses = achiever.approved_online_course_templates
    @courses = face_to_face_courses + online_courses
    @course_occurrences = achiever.future_courses
    @course_occurrences = achiever.future_courses

    @courses.each do |course|
      achiever.course_template_subject_details(course)
      achiever.course_template_age_range(course)
      @course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
        end
      end
    end
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

    it 'renders course key stage tags' do
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Key stage 3')
    end

    it 'renders course subject tags' do
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Computing')
    end
  end
end
