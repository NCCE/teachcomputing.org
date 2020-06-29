require 'rails_helper'

RSpec.describe Curriculum::KeyStagesController do
  describe 'GET #index' do
    context 'when curriculum is enabled' do
      it 'renders the index template' do
        get curriculum_key_stages_path
        expect(response).to render_template(:index)
      end
    end

    context 'when curriculum is not enabled' do
      before do
        allow_any_instance_of(Curriculum::KeyStagesController)
          .to receive(:curriculum_enabled?).and_return(true)
      end

      it 'redirects to the root path' do
        get curriculum_key_stages_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
