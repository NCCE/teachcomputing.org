require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.find_by_activity_code('CP201') }
  let(:activity) { create(:activity, stem_course_id: course.course_template_no) }
  let(:programme) { create(:cs_accelerator) }
  let(:programme_activity) {
    programme.activities << activity
  }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

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

    context 'when the course is part of a programme' do
      before do
        programme_activity
        get course_path(id: course.activity_code, name: 'this-is-a-name')
      end

      it 'sets the programme' do
        expect(assigns(:programme)).to eq(programme)
      end

      it 'has a link to the programme' do
        expect(response.body).to include(programme_path(programme.slug))
      end
    end

    context 'when user is logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
      end

      context 'and enrolled' do
        before do
          user_programme_enrolment
          get course_path(id: course.activity_code, name: 'this-is-a-name')
        end

        it 'has no link to the programme' do
          expect(response.body).not_to include(programme_path(programme.slug)) 
        end

        it 'shows enrolment status' do
          expect(response.body).not_to include('You are enrolled')
        end
      end
    end
  end
end
