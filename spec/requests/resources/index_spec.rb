require 'rails_helper'

RSpec.describe ResourcesController do
  describe '#index' do
    it 'renders the index template' do
      get resources_path
      expect(response).to render_template(:index)
    end
  end
end
