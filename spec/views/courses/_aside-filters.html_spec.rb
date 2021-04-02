require 'rails_helper'

RSpec.describe('courses/_aside-filters', type: :view) do
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
    certificates = {
      'cs-accelerator': 'CS Accelerator',
      'secondary-certificate': 'Secondary Certificate',
      'primary-certificate': 'Primary Certificate'
    }

    filter_stub = instance_double(Achiever::CourseFilter)

    allow(filter_stub).to receive_messages(
      course_tags: { Algorithms: '101' },
      age_groups: age_groups,
      subjects: subjects,
      certificates: certificates,
      courses: courses,
      course_formats: %i[face_to_face online remote],
      course_locations: ['Cambridge'],
      current_hub: nil,
      current_level: nil, current_location: nil,
      current_topic: nil, current_certificate: nil,
      applied_filters: nil
    )

    @filter_params = { hub_id: 'bla' }
    @course_filter = filter_stub
    render
  end

  describe 'courses' do
    it 'renders filter selects' do
      expect(rendered).to have_css('.ncce-select', count: 4)
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

    # TODO: When je-enabled true / false
    # it 'renders filter submit' do
    #   expect(rendered).to have_css('.button[value="Apply filter"]', count: 1)
    # end
  end
end
