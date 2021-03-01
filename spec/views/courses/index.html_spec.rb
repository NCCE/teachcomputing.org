require 'rails_helper'

RSpec.describe('courses/index', type: :view) do
  let(:courses) do
    build_list(
      :achiever_course_template,
      3,
      age_groups: ['157430010'],
      subjects: ['157430000'],
      occurrences: [build(:achiever_course_occurrence)]
    )
  end

  before do
    subjects = { 'Algorithmic thinking' => 100_000_011, 'Biology' => 157_430_000, 'Careers' => 157_430_001 }
    age_groups = { 'Key stage 1' => 157_430_008, 'Key stage 2' => 157_430_009, 'Key stage 3' => 157_430_010,
                   'Key stage 4' => 157_430_011 }

    filter_stub = instance_double(Achiever::CourseFilter)

    allow(filter_stub).to receive_messages(
      course_tags: { Algorithms: '101' },
      age_groups: age_groups,
      subjects: subjects,
      courses: courses,
      course_locations: ['Cambridge'],
      current_level: nil, current_location: nil,
      current_topic: nil, current_certificate: nil,
      applied_filters: nil
    )

    @course_filter = filter_stub
    render
  end

  it 'has a title' do
    expect(rendered).to have_css(
      '.govuk-heading-xl',
      text: 'Computing courses for teachers'
    )
  end

  it 'links to the course landing page for each course' do
    courses.each do |course|
      expect(rendered).to have_link(course.title, href: %r{#{course.activity_code}/#{course.title.parameterize}})
    end
  end

  it 'renders the bursary partial' do
    expect(rendered).to render_template(partial: 'courses/_aside-bursary')
  end

  describe 'courses' do
    it 'renders each of the course template titles' do
      courses.each do |course|
        expect(rendered).to have_css('.ncce-courses__heading', text: course.title)
      end
    end

    it 'renders each of the course template codes' do
      courses.each do |course|
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
      expect(rendered).to have_css('.ncce-courses__tag', text: 'Biology')
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
      expect(rendered).to have_css('.button[value="Apply filter"]', count: 1)
    end

    it 'not to render an asides' do
      expect(rendered).not_to have_css('.ncce-aside')
    end
  end
end
