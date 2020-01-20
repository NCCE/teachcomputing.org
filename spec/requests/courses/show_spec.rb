require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.find_by_activity_code('CP201') }

  describe 'GET #show' do
    before do
      stub_course_templates
    end

    it 'raises a 404 not found' do
      expect { get course_path(id: 'ZZ101', name: 'this-is-a-dud') }.to raise_error(ActiveRecord::RecordNotFound)
    end

    context 'when the course exists' do
      before do
        get course_path(id: course.activity_code, name: 'this-is-a-name')
      end

      it 'sets the course correctly' do
        expect(assigns(:course).title).to eq("#{course.title}")
      end

      it 'sets the programme' do
        expect(assigns(:programme)).to eq(nil)
      end
    end

    context 'when user is logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      end
    end
  end
end
