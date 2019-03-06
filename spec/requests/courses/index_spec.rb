require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before do
      stub_fetch_future_courses
      stub_approved_course_templates
      stub_course_template_subject_details
      stub_course_template_age_range

      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

    end

    context 'without filtering' do
      before do
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

      it 'assigns all locations' do
        expect(assigns(:locations).sort).to eq([ 'Cambridge', 'Southampton', 'York'])
      end

      it 'assigns all levels' do
        expect(assigns(:levels).sort).to eq(['Key stage 2', 'Key stage 3', 'Key stage 4'])
      end

      it 'assigns all topics' do
        expect(assigns(:topics).sort).to eq(['Computing', 'Mathematics'])
      end

      it 'can retrieve course tags correctly' do
        courses = assigns(:courses)
        courses.each.with_index do |course, index|
          subject = index < 4 ? ['Computing'] : ['Mathematics']
          expect(course.subjects).to eq(subject)
        end
      end

      it 'can retrieve course key stage correctly' do
        courses = assigns(:courses)
        courses.each.with_index do |course, index|
          key_stages = index < 2 ? ['Key stage 3', 'Key stage 4'] : ['Key stage 2', 'Key stage 3']
          expect(course.key_stages.sort).to eq(key_stages)
        end
      end

      it 'renders the correct template' do
        expect(response).to render_template('index')
      end
    end

    context 'with filtering' do
      it 'can filter by subject' do
        get courses_path, params: { topic: 'Mathematics' }
        courses = assigns(:courses)
        expect(courses.length).to be(4)
        courses.each do |course|
          expect(course.subjects).to eq(['Mathematics'])
        end
      end

      it 'can filter by location' do
        get courses_path, params: { location: 'Southampton' }
        courses = assigns(:courses)
        expect(courses.length).to be(1)
        courses.each do |course|
          expect(course.occurrences.map { |oc | oc.address_town }).to eq(['Southampton'])
        end
      end

      it 'can filter by location but doesn\'t exclude other occurrences' do
        get courses_path, params: { location: 'Cambridge' }
        courses = assigns(:courses)
        expect(courses.length).to be(1)
        courses.each do |course|
          expect(course.occurrences.map { |oc | oc.address_town }).to eq(['Cambridge', 'York'])
        end
      end

      it 'can filter by level' do
        get courses_path, params: { level: 'Key stage 4' }
        courses = assigns(:courses)
        expect(courses.length).to be(2)
        courses.each do |course|
          expect(course.key_stages).to eq(['Key stage 3', 'Key stage 4'])
        end
      end

      it 'can filter by level 2' do
        get courses_path, params: { level: 'Key stage 3' }
        courses = assigns(:courses)
        expect(courses.length).to be(8)
        courses.each do |course|
          expect(course.key_stages).to include('Key stage 3')
        end
      end
    end
  end
end
