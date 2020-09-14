require 'rails_helper'

RSpec.describe Curriculum::UnitsController do
  let(:unit_json_response) { File.new('spec/support/curriculum/responses/unit.json').read }

  describe 'GET #show' do
    it 'renders the show template' do
      stub_a_valid_request(unit_json_response)
      get curriculum_key_stage_unit_path(key_stage_slug: 'key-stage-3', unit_slug: 'representations-from-clay-to-silicon')
      expect(response).to render_template(:show)
    end
  end
end
