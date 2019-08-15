require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }

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
        occurrence = assigns(:courses).select { |course| course.course_template_no == assigns(:course_occurrences).sample.course_template_no }
        expect(occurrence).not_to eq 0
      end

      it 'assigns @locations' do
        expect(assigns(:locations)).to be_a(Array)
      end

      it 'assigns @levels' do
        expect(assigns(:levels)).to be_a(Hash)
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
      context 'when filtering by subject' do
        before do
          get courses_path, params: { topic: 'Mathematics' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(3)
        end

        it 'initalises current topic' do
          expect(assigns(:current_topic)).to eq('Mathematics')
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Topic<\/strong>: Mathematics/)
        end

        it 'flash notice has a link to remove filtering' do
          expect(flash[:notice]).to match(/<a href="#{url_for(controller: 'courses', anchor: 'filter-results')}">Remove filter<\/a>/)
        end
      end

      context 'when filtering by location' do
        before do
          get courses_path, params: { location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(12)
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

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Location<\/strong>: York/)
        end
      end

      context 'when filtering by Online location' do
        before do
          get courses_path, params: { location: 'Online' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(14)
        end

        it 'ensures the course templates are marked as online_cpd' do
          assigns(:courses).each do |course|
            expect(course.online_cpd).to eq true
          end
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('Online')
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Location<\/strong>: Online/)
        end
      end

      context 'when filtering by Face to face location' do
        before do
          get courses_path, params: { location: 'Face to face' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(20)
        end

        it 'course templates are not marked as online' do
          assigns(:courses).each do |course|
            expect(course.online_cpd).to eq false
          end
        end

        it 'initalises current location' do
          expect(assigns(:current_location)).to eq('Face to face')
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Location<\/strong>: Face to face/)
        end
      end

      context 'when filtering by level' do
        before do
          get courses_path, params: { level: 'Key stage 4' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(22)
        end

        it 'initalises current level' do
          expect(assigns(:current_level)).to eq('Key stage 4')
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Level<\/strong>: Key stage 4/)
        end
      end

      context 'when filtering by workstream' do
        before do
          get courses_path, params: { workstream: 'CS Accelerator' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(20)
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Programme<\/strong>: CS Accelerator/)
        end
      end

      context 'when filtering by level and location' do
        before do
          get courses_path, params: { level: 'Key stage 4', location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(7)
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Location<\/strong>: York/)
          expect(flash[:notice]).to match(/<strong>Level<\/strong>: Key stage 4/)
        end
      end

      context 'when filtering by level and topic' do
        before do
          get courses_path, params: { level: 'Key stage 3', topic: 'Computing' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(15)
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Topic<\/strong>: Computing/)
          expect(flash[:notice]).to match(/<strong>Level<\/strong>: Key stage 3/)
        end
      end

      context 'filter by level, location and topic' do
        before do
          get courses_path, params: {
            level: 'Key stage 4',
            topic: 'Computing',
            location: 'York'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(7)
        end

        it 'has filtered town' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('York')
        end

        it 'doesn\'t exclude other occurrence locations' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('London')
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Topic<\/strong>: Computing/)
          expect(flash[:notice]).to match(/<strong>Location<\/strong>: York/)
          expect(flash[:notice]).to match(/<strong>Level<\/strong>: Key stage 4/)
        end
      end

      context 'filter by level, location, topic and workstream' do
        before do
          get courses_path, params: {
            level: 'Key stage 4',
            topic: 'Computing',
            location: 'York',
            workstream: 'CS Accelerator'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(5)
        end

        it 'has filtered town' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('York')
        end

        it 'doesn\'t exclude other occurrence locations' do
          course = assigns(:courses).first
          expect(course.occurrences.map(&:address_town)).to include('London')
        end

        it 'has correct workstream' do
          assigns(:courses).each do |course|
            expect(course.workstream).to eq('CS Accelerator')
          end
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Topic<\/strong>: Computing/)
          expect(flash[:notice]).to match(/<strong>Location<\/strong>: York/)
          expect(flash[:notice]).to match(/<strong>Level<\/strong>: Key stage 4/)
          expect(flash[:notice]).to match(/<strong>Programme<\/strong>: CS Accelerator/)
        end
      end
    end
  end
end
