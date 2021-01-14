require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator', title: 'CS Accelerator') }

  describe 'GET #index' do
    before do
      activity
      stub_age_groups
      stub_course_templates
      stub_face_to_face_occurrences
      stub_online_occurrences
      stub_subjects

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

      it 'assigns adds course_occurrences to their respective courses' do
        occurrence = assigns(:courses).select do |course|
          course.course_template_no == assigns(:course_occurrences).sample.course_template_no
        end
        expect(occurrence).not_to eq 0
      end

      it 'assigns @locations' do
        expect(assigns(:locations)).to be_a(Array)
      end

      it 'assigns @age_groups' do
        expect(assigns(:age_groups)).to be_a(Hash)
      end

      it 'assigns all @subjects' do
        expect(assigns(:subjects)).to be_a(Hash)
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

      it 'renders the correct template' do
        expect(response).to render_template('index')
      end

      it 'doesn\'t show a flash notice' do
        expect(flash[:notice]).not_to be_present
      end
    end

    context 'when using filtering' do
      context 'when filtering by certificate' do
        before do
          programme
          get courses_path, params: { certificate: 'cs-accelerator' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(45)
        end

        it 'initalises current certificate' do
          expect(assigns(:current_certificate)).to eq programme
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('CS Accelerator')
        end
      end

      context 'when filtering by subject' do
        before do
          get courses_path, params: { topic: 'Mathematics' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(1)
        end

        it 'initalises current topic' do
          expect(assigns(:current_topic)).to eq('Mathematics')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Mathematics')
        end
      end

      context 'when filtering by location' do
        before do
          get courses_path, params: { location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(5)
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

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('York')
        end
      end

      context 'when filtering by Online location' do
        before do
          get courses_path, params: { location: 'Online' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(25)
        end

        it 'ensures the course templates are marked as online_cpd' do
          assigns(:courses).each do |course|
            expect(course.online_cpd).to eq true
          end
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('Online')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Online')
        end
      end

      context 'when filtering by Face to face location' do
        before do
          get courses_path, params: { location: 'Face to face' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(30)
        end

        it 'course templates are not marked as online' do
          assigns(:courses).each do |course|
            expect(course.online_cpd).to eq false
          end
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('Face to face')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Face to face')
        end
      end

      context 'when filtering by Remote' do
        before do
          get courses_path, params: { location: 'Remote' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(24)
        end

        it 'course templates are not marked as online' do
          assigns(:courses).each do |course|
            expect(course.online_cpd).to eq false
          end
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('Remote')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Remote')
        end
      end

      context 'when filtering by level' do
        before do
          get courses_path, params: { level: 'Key stage 4' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(54)
        end

        it 'initalises current level' do
          expect(assigns(:current_level)).to eq('Key stage 4')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Key stage 4')
        end
      end

      context 'when filtering by level and location' do
        before do
          get courses_path, params: { level: 'Key stage 4', location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(0)
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Key stage 4')
          expect(assigns(:filters)).to include('York')
        end
      end

      context 'when filtering by level and topic' do
        before do
          get courses_path, params: { level: 'Key stage 3', topic: 'Computing' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(33)
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Key stage 3')
          expect(assigns(:filters)).to include('Computing')
        end
      end

      context 'filter by level, location and topic' do
        before do
          get courses_path, params: {
            level: 'Key stage 2',
            topic: 'Computing',
            location: 'Swindon'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(2)
        end

        it 'has filtered town' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('Swindon')
        end

        it 'doesn\'t exclude other occurrence locations' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('London')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Key stage 2')
          expect(assigns(:filters)).to include('Swindon')
          expect(assigns(:filters)).to include('Computing')
        end
      end

      context 'filter by level, location, and topic' do
        before do
          programme
          get courses_path, params: {
            level: 'Key stage 1',
            topic: 'Computing',
            location: 'Redruth'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(1)
        end

        it 'has filtered town' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('Redruth')
        end

        it 'doesn\'t exclude other occurrence locations' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('York')
        end

        it 'assigns the filters variable' do
          expect(assigns(:filters)).to be_present
        end

        it 'has correct info' do
          expect(assigns(:filters)).to include('Key stage 1')
          expect(assigns(:filters)).to include('Redruth')
          expect(assigns(:filters)).to include('Computing')
        end
      end

      context 'filter escapes input' do
        before do
          programme
          get courses_path, params: {
            certificate: '<h1>Not a cert</h1>',
            level: '<p>My XSS is excessive</p>',
            topic: '<script>alert("boom")</script>',
            location: '<svg onload=alert(1)>'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(0)
        end

        it 'level param is escaped' do
          expect(assigns(:filters)).to include(%r{&lt;p&gt;My XSS is excessive&lt;/p&gt;})
        end

        it 'topic param is escaped' do
          expect(assigns(:filters)).to include(%r{&lt;script&gt;alert\(&quot;boom&quot;\)&lt;/script&gt;})
        end

        it 'location param is escaped' do
          expect(assigns(:filters)).to include(/&lt;svg onload=alert\(1\)&gt;/)
        end

        it 'invalid certificate does not cause filtering' do
          expect(assigns(:filters)).not_to include(%r{&lt;h1&gt;Not a cert&lt;/h1&gt;})
        end
      end
    end
  end
end
