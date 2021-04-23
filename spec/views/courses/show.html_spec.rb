require 'rails_helper'

RSpec.describe('courses/show', type: :view) do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:course) { Achiever::Course::Template.all.first }

  before do
    cs_accelerator
    stub_course_templates

    assign(:course, course)
    assign(:other_courses, [])
    assign(:age_groups, {})
    assign(:occurrences, [])
    assign(:programmes, Programme.enrollable)

    stub_template 'courses/_aside-booking': ''
  end

  describe 'renders' do
    before do
      render
    end

    it 'the hero partial' do
      expect(rendered).to render_template(partial: '_hero')
    end

    it 'the asides partial' do
      expect(rendered).to render_template(partial: '_aside-booking')
    end

    it 'a course summary' do
      expect(rendered).to have_css('h2.govuk-body-m', text: course.meta_description)
    end

    it 'the courses details partial' do
      expect(rendered).to render_template(partial: '_courses-details')
    end

    it 'a course description' do
      expect(rendered).to have_css('.external-content')
      expect(rendered).to have_text(strip_tags(sanitize_stem_html(course.summary)))
      expect(rendered).to have_text(strip_tags(sanitize_stem_html(course.outcomes)))
    end

    it 'the certificates card partial' do
      expect(rendered).to render_template(partial: '_certificates-card')
    end

    it 'the courses cards partial' do
      expect(rendered).to render_template(partial: '_courses-cards')
    end
  end

  it 'has attempted to sanitize the description html' do
    allow(view).to receive(:sanitize_stem_html)
    render

    expect(view).to have_received(:sanitize_stem_html).with(course.summary)
    expect(view).to have_received(:sanitize_stem_html).with(course.outcomes)
  end
end
