require 'rails_helper'

RSpec.describe Curriculum::LessonsController do
  let(:lesson_json_response) { File.new('spec/support/curriculum/responses/lesson.json').read }

  describe 'GET #show' do
    it 'renders the show template' do
      stub_a_valid_request(lesson_json_response)
      get curriculum_key_stage_unit_lesson_path(key_stage_slug: 'key-stage-3', unit_slug: 'representations-from-clay-to-silicon', lesson_slug: 'lesson-1-across-time-and-space')
      expect(response).to render_template(:show)
    end
  end
end
