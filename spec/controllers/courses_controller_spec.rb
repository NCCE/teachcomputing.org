require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    before do
      get :index
    end

    xit 'assigns @future_learn' do
      expect(assigns(:online_courses)).to be_a(FutureLearn)
    end

    xit 'renders the correct template' do
      expect(response).to render_template('index')
    end
  end
end
