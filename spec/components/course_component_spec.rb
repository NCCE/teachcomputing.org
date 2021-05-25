require "rails_helper"

RSpec.describe CourseComponent, type: :component do
  let(:course) { build(:achiever_course_template, activity_code: 'abc', title: 'test course') }
  let(:filter) { instance_double(Achiever::CourseFilter) }

  before do
    allow(filter).to receive_messages(
      subjects: { 'Algorithms' => 000000000, 'Other' => 222222222 },
      age_groups: { 'Key stage 1' => 000000000, 'Key stage 2' => 222222222 }
    )
  end

  it 'has a title' do
    render_inline(described_class.new(course: course, filter: filter))
    expect(rendered_component).to have_text(course.title)
  end

  it 'shows link to course' do
    render_inline(described_class.new(course: course, filter: filter))
    expect(rendered_component).to have_link(course.title, href: '/courses/abc/test-course')
  end

  it 'shows subjects' do
    render_inline(described_class.new(course: course, filter: filter))
    expect(rendered_component).to have_text('Algorithms')
  end

  it 'shows programmes' do
    render_inline(described_class.new(course: course, filter: filter))
    expect(rendered_component).to have_text('CS Accelerator')
  end

  it 'shows age groups' do
    render_inline(described_class.new(course: course, filter: filter))
    expect(rendered_component).to have_text('Key stage 1')
  end

  context 'when multiple course occurrences are present' do
    let(:occurrences) { build_list(:achiever_course_occurrence, 2) }
    let(:course) { build(:achiever_course_template, occurrences: occurrences) }

    it 'shows locations' do
      render_inline(described_class.new(course: course, filter: filter))
      expect(rendered_component).to have_css('.ncce-courses__locations', count: 1)
    end

    context 'when distance information present' do
      let(:occurrences) { build_list(:achiever_course_occurrence, 2, distance: 3) }
      let(:course) { build(:achiever_course_template, occurrences: occurrences) }

      it 'shows nearest distance' do
        render_inline(described_class.new(course: course, filter: filter))
        expect(rendered_component).to have_text('Nearest 3 miles away')
      end
    end
  end
end
