require 'rails_helper'

RSpec.describe Curriculum::KeyStagesController do
  describe 'GET #index' do
    before do
      get curriculum_key_stages_path
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
