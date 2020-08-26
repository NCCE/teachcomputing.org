require 'rails_helper'

RSpec.describe('courses/show', type: :view) do
  let(:programme) { create(:cs_accelerator) }

  before do
    stub_age_groups
    stub_course_templates
    stub_face_to_face_occurrences
    stub_online_occurrences
    stub_subjects

    courses = Achiever::Course::Template.all
    course_occurrences = Achiever::Course::Occurrence.face_to_face + Achiever::Course::Occurrence.online

    @course = courses[0]
    assign(:other_courses, courses)
    assign(:age_groups, Achiever::Course::AgeGroup.all)
    assign(:occurrences, course_occurrences)

    render
  end

  it 'renders the hero component' do
    expect(rendered).to render_template(:partial => '_hero')
  end

  it 'renders the asides partial' do
    expect(rendered).to render_template(:partial => '_aside-section')
  end

  it 'has a course summary' do
    expect(rendered).to have_css('h2.govuk-body-m', text: @course.meta_description)
  end

  it 'renders the courses details partial' do
    expect(rendered).to render_template(:partial => '_courses-details')
  end

  it 'has a course description' do
    expect(rendered).to have_text(strip_tags(sanitize_stem_html(@course.summary)))
    expect(rendered).to have_text(strip_tags(sanitize_stem_html(@course.outcomes)))
  end

  it 'renders the courses card partial' do
    expect(rendered).to render_template(:partial => '_courses-card')
  end

  it 'renders the courses list partial' do
    expect(rendered).to render_template(:partial => '_courses-list')
  end
end
