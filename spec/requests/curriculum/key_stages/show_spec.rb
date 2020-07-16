require 'rails_helper'

RSpec.describe Curriculum::KeyStagesController do
  describe 'GET #index' do
    context 'when curriculum is enabled' do
      before do
        stub_a_valid_request({ 'keyStages': [] })

        allow_any_instance_of(described_class)
          .to receive(:curriculum_enabled?).and_return(true)
      end

      it 'renders the show template' do
        get curriculum_key_stage_units(key_stages_slug: 'key-stage-1')
        expect(response).to render_template(:index)
      end
    end

    context 'when curriculum is not enabled' do
      it 'redirects to the root path' do
        get curriculum_key_stage_units(key_stages_slug: 'key-stage-1')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
