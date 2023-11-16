require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.find_by_activity_code('CP228') }
  let(:online_course) { Achiever::Course::Template.find_by_activity_code('CO214') }
  let(:activity) { create(:activity, stem_course_template_no: course.course_template_no, stem_activity_code: course.activity_code) }
  let(:activity2) { create(:activity, stem_course_template_no: online_course.course_template_no, stem_activity_code: online_course.activity_code) }
  let(:programme) { create(:cs_accelerator) }
  let(:programme_activity) do
    programme.activities << activity
  end
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  describe 'GET #show' do
    before do
      stub_duration_units
      stub_face_to_face_occurrences
      stub_online_occurrences
      stub_subjects
      stub_age_groups
      stub_course_templates
      stub_attendance_sets
      stub_delegate
      activity
    end

    it 'raises a 404 not found' do
      expect { get course_path(id: 'ZZ101', name: 'this-is-a-dud') }.to raise_error(ActiveRecord::RecordNotFound)
    end

    context 'when the course exists' do
      before do
        get course_path(id: course.activity_code, name: 'this-is-a-name')
      end

      it 'sets the age_groups' do
        expect(assigns(:age_groups)).not_to be_nil
      end

      it 'sets the course correctly' do
        expect(assigns(:course).title).to eq(course.title.to_s)
      end

      it 'sets the programmes' do
        expect(assigns(:programmes).count).to eq(0)
      end

      it 'assigns list of occurrences' do
        expect(assigns(:occurrences)).not_to be_nil
      end

      it 'assigns list of other_courses' do
        expect(assigns(:other_courses)).not_to be_nil
      end

      it 'the single course is not in the list of other_courses' do
        expect(assigns(:other_courses).map(&:course_template_no).include?(course.course_template_no)).to be(false)
      end

      it 'sets the activity' do
        expect(assigns(:activity)).to eq(activity)
      end
    end

    context 'when the url just contains the activity code' do
      before do
        get course_path(id: course.activity_code)
      end

      it 'redirects' do
        expect(response.status).to eq(302)
      end

      it 'adds the course title to the redirect url' do
        expect(response).to redirect_to(%r{/#{course.title.parameterize}$})
      end
    end

    context 'when the course is part of a programme' do
      before do
        programme_activity
        get course_path(course.activity_code, name: 'this-is-a-dud')
      end

      it 'sets the programme' do
        expect(assigns(:programmes)).to include(programme)
      end

      it 'has a link to the programme' do
        expect(response.body).to include(programme.path)
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
          get course_path(course.activity_code, name: 'this-is-a-dud')
        end

        it 'shows enrolment status' do
          expect(response.body).not_to include('You are enrolled')
        end
      end

      it 'asks client not to cache private progress' do
        get course_path(course.activity_code, name: 'this-is-a-dud')
        expect(response.headers['cache-control']).to eq('no-store')
      end
    end

    context 'when the course is online' do
      before do
        user_programme_enrolment
        activity2
        get course_path(id: online_course.activity_code, name: online_course.title.parameterize)
      end

      it 'assigns the correct presenter' do
        expect(response.body).to include('Join this course')
      end
    end

    context 'when the course is remote or face to face' do
      before do
        user_programme_enrolment
        get course_path(id: course.activity_code, name: online_course.title.parameterize)
      end

      it 'assigns the correct presenter' do
        expect(response.body).to include('Book this course')
      end
    end
  end
end
