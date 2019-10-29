require 'rails_helper'

RSpec.describe('courses/index', type: :view) do
  before do
    stub_age_groups
    stub_course_templates
    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_subjects
    @courses = Achiever::Course::Template.all
    @subjects = Achiever::Course::Subject.all
    @age_groups = Achiever::Course::AgeGroup.all
    @course_occurrences = Achiever::Course::Occurrence.face_to_face + Achiever::Course::Occurrence.online

    @courses.each do |course|
      @course_occurrences.each do |course_occurrence|
        if course_occurrence.course_template_no == course.course_template_no
          course.occurrences.push(course_occurrence)
        end
      end
    end

    @locations = ['Cambridge']
    @levels = @age_groups
    @topics = { 'Algorithms': '101' }

    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Courses')
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
    end

    it 'has a create account link' do
      expect(rendered).to have_link('Create an account', href: /register/)
    end
  end

  describe 'courses' do
    it 'renders each of the course template titles' do
      @courses.each do |course|
        expect(rendered).to have_css('.govuk-heading-s', text: course.title)
      end
    end

    it 'renders each of the course template codes' do
      @courses.each do |course|
        expect(rendered).to have_css('.ncce-courses__heading-code', text: course.activity_code)
      end
    end

    it 'renders course key stage tags' do
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Key stage 3')
    end

    it 'renders course subject tags area' do
      expect(rendered).to have_css('h3.screen-reader-only', text: 'Tags for this course')
    end

    it 'renders course subject tags' do
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Computing')
    end

    it 'renders filter selects' do
      expect(rendered).to have_css('.ncce-select', count: 3)
    end

    it 'renders location select' do
      expect(rendered).to have_css('.ncce-select option', text: 'Cambridge')
    end

    it 'renders level select' do
      expect(rendered).to have_css('.ncce-select option', text: 'Key stage 2')
    end

    it 'renders topic select' do
      expect(rendered).to have_css('.ncce-select option', text: 'Algorithms')
    end

    it 'renders filter submit' do
      expect(rendered).to have_css('.ncce-button__pink[value="Apply filter"]', count: 1)
    end

  end
end
