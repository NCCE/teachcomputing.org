require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before do
      stub_fetch_future_courses
      stub_approved_course_templates
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      get courses_path()
    end

    it 'assigns @courses' do
      expect(assigns(:courses)).to be_a(Array)
    end

    it 'assigns @course_occurrences' do
      expect(assigns(:course_occurrences)).to be_a(Array)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end
  end
end
