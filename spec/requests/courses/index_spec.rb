require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before do
      stub_approved_course_templates
      stub_fetch_future_face_to_face_courses
      stub_fetch_future_online_courses
      stub_course_template_subject_details
      stub_course_template_age_range
      
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      get courses_path()
    end

    it 'assigns @courses' do
      expect(assigns(:courses)).to be_a(Array)
    end

    it 'has at least one course' do
      expect(assigns(:courses).length).to be >(0)
    end

    it 'assigns course_occurrences correctly' do
      courses = assigns(:courses)
      courses.each do |course|
        expect(course.occurrences).to be_a(Array)
        if course.course_template_no == '0f9644e0-afda-4307-b195-82fb62f5f8ab'
          expect(course.occurrences.length).to equal(1)
        end
      end
    end

    it 'can retrieve course tags correctly' do
      courses = assigns(:courses)
      courses.each do |course|
        expect(course.subjects).to be_a(Array)
        expect(course.subjects.length).to be(1)
        expect(course.subjects.first).to eq('Computing')
      end
    end

    it 'can retrieve course key stage correctly' do
      courses = assigns(:courses)
      courses.each do |course|
        expect(course.key_stages).to eq(['Key stage 3', 'Key stage 4'])
      end
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end
  end
end
