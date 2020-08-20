require 'rails_helper'

RSpec.describe Curriculum::KeyStagesController do
  let(:key_stages_json_response) { File.new('spec/support/curriculum/responses/key_stages.json').read }

  describe 'GET #index' do
    context 'when curriculum is enabled' do
      before do
        stub_a_valid_request(key_stages_json_response)
      end

      it 'renders the index template' do
        get curriculum_key_stages_path
        expect(response).to render_template(:index)
      end
    end
  end
end
