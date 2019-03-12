require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }

  describe 'GET #index' do
    before do
      activity
      stub_approved_course_templates
      stub_fetch_future_face_to_face_courses
      stub_fetch_future_online_courses
      stub_course_template_subject_details
      stub_course_template_age_range

      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    context 'when there is no filtering' do
      before do
        get courses_path
      end

      it 'assigns @courses' do
        expect(assigns(:courses)).to be_a(Array)
      end

      it 'has at least one course' do
        expect(assigns(:courses).length).to be > 0
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
        expect(assigns(:locations).sort).to eq(%w[Cambridge Online Southampton York])
      end

      it 'assigns all levels' do
        expect(assigns(:levels).sort)
          .to eq(['Key stage 2', 'Key stage 3', 'Key stage 4'])
      end

      it 'assigns all topics' do
        expect(assigns(:topics).sort).to eq(%w[Computing Mathematics])
      end

      it 'initalises current location' do
        expect(assigns(:current_location)).to be(nil)
      end

      it 'initalises current level' do
        expect(assigns(:current_level)).to be(nil)
      end

      it 'initalises current topic' do
        expect(assigns(:current_topic)).to be(nil)
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
          key_stages = (index / 2).even? ? ['Key stage 3', 'Key stage 4'] : ['Key stage 2', 'Key stage 3']
          expect(course.key_stages.sort).to eq(key_stages)
        end
      end

      it 'renders the correct template' do
        expect(response).to render_template('index')
      end
    end

    context 'when using filtering' do
      context 'when filtering by subject' do
        before do
          get courses_path, params: { topic: 'Mathematics' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(4)
        end

        it 'courses have correct subject' do
          assigns(:courses).each do |course|
            expect(course.subjects).to eq(['Mathematics'])
          end
        end

        it 'initalises current topic' do
          expect(assigns(:current_topic)).to eq('Mathematics')
        end
      end

      context 'when filtering by location' do
        before do
          get courses_path, params: { location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(2)
        end

        it 'courses have correct location' do
          assigns(:courses).each do |course|
            expect(course.occurrences.map(&:address_town)).to include('York')
          end
        end

        it 'doesn\'t exclude other occurrence locations' do
          towns = assigns(:courses).reduce([]) do |acc, course|
            acc + course.occurrences.map(&:address_town)
          end
          expect(towns).to include('Cambridge')
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('York')
        end
      end

      context 'when filtering by Online location' do
        before do
          get courses_path, params: { location: 'Online' }
          assigns(:courses).each do |course|
            puts "course: #{course.title}, #{course.occurrences.map(&:online_course)}"
          end
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(2)
        end

        it 'courses have correct location' do
          assigns(:courses).each do |course|
            expect(assigns(:courses).first.occurrences.map(&:online_course)).to include(1)
          end
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('Online')
        end
      end

      context 'when filtering by level' do
        before do
          get courses_path, params: { level: 'Key stage 4' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(4)
        end

        it 'courses have correct key_stages' do
          assigns(:courses).each do |course|
            expect(course.key_stages).to eq(['Key stage 3', 'Key stage 4'])
          end
        end

        it 'initalises current level' do
          expect(assigns(:current_level)).to eq('Key stage 4')
        end
      end

      context 'when filtering by level and location' do
        before do
          get courses_path, params: { level: 'Key stage 4', location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(1)
        end

        it 'has correct levels' do
          expect(assigns(:courses).first.key_stages).to eq(['Key stage 3', 'Key stage 4'])
        end

        it 'has correct location' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('York')
        end

      end

      context 'when filtering by level and topic' do
        before do
          get courses_path, params: { level: 'Key stage 2', topic: 'Mathematics' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(2)
        end

        it 'has correct topic' do
          assigns(:courses).each do |course|
            expect(course.subjects).to eq(['Mathematics'])
          end
        end

        it 'has correct level' do
          assigns(:courses).each do |course|
            expect(course.key_stages).to eq(['Key stage 3', 'Key stage 2'])
          end
        end
      end

      context 'filter by level, location and topic' do
        before do
          get courses_path, params: {
            level: 'Key stage 2',
            topic: 'Mathematics',
            location: 'York'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).length).to be(1)
        end

        it 'has correct topic' do
          assigns(:courses).each do |course|
            expect(course.subjects).to eq(['Mathematics'])
          end
        end

        it 'has correct level' do
          assigns(:courses).each do |course|
            expect(course.key_stages).to eq(['Key stage 3', 'Key stage 2'])
          end
        end

        it 'has filtered town' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('York')
        end

        it 'doesn\'t exclude other occurrence locations' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('Cambridge')
        end
      end
    end
  end
end
