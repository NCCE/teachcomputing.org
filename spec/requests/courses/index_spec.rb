require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    describe 'while logged in' do
      before do
        stub_fetch_future_courses
        stub_approved_course_templates
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get courses_path()
      end

      it 'assigns @face_to_face_courses' do
        expect(assigns(:face_to_face_courses)).to be_a(Array)
      end

      it 'assigns @face_to_face_course_occurrences' do
        expect(assigns(:face_to_face_course_occurrences)).to be_a(Array)
      end

      it 'renders the correct template' do
        expect(response).to render_template('index')
      end
    end

    describe 'while logged out' do
      before do
        get courses_path()
      end

      it 'should redirect to login' do
        get courses_path()
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
