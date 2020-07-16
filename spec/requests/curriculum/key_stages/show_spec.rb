require 'rails_helper'

RSpec.describe Curriculum::KeyStagesController do
  let(:key_stage_json_response) { File.new('spec/support/curriculum/responses/key_stage.json').read }

  describe 'GET #show' do
    context 'when curriculum is enabled' do
      before do
        stub_a_valid_request(key_stage_json_response)

        allow_any_instance_of(described_class)
          .to receive(:curriculum_enabled?).and_return(true)
      end

      it 'renders the show template' do
        get curriculum_key_stage_units_path(key_stage_slug: 'key-stage-1')
        expect(response).to render_template(:show)
      end
    end

    context 'when key stages are null' do

    end

    context 'when curriculum is not enabled' do
      it 'redirects to the root path' do
        get curriculum_key_stage_units_path(key_stage_slug: 'key-stage-1')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
