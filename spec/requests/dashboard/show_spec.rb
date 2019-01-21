require 'rails_helper'

RSpec.describe DashboardController do
  let(:user) { create(:user) }
  let(:achievements) { create(:achievements, user: user) }

  describe '#show' do
    describe 'while logged in' do
      before do
        stub_delegate_course_list
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get dashboard_path
      end

      it 'assigns the users achievements' do
        expect(assigns(:achievements)).to eq user.achievements
      end

      it 'assigns @delegate_course_list' do
        course_list = assigns(:delegate_course_list)
        expect(course_list).to be_a(Array)
        expect(course_list.length).to eq 1
        expect(course_list[0].activity_title).to eq 'Test Course 2'
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end
    end

    describe 'while logged out' do
      before do
        get dashboard_path
      end

      it 'should redirect to login' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
