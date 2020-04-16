require 'rails_helper'

RSpec.describe CoursesController do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator')}

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

      it 'has correct number of courses' do
        expect(assigns(:courses).count).to eq(37)
      end

      it 'assigns adds course_occurrences to their respective courses' do
        occurrence = assigns(:courses).select { |course| course.course_template_no == assigns(:course_occurrences).sample.course_template_no }
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
          expect(assigns(:courses).count).to eq(23)
        end

        it 'initalises current certificate' do
          expect(assigns(:current_certificate)).to eq programme
        end

        it 'shows a flash notice' do
          expect(flash[:notice]).to be_present
        end

        it 'flash notice has correct info' do
          expect(flash[:notice]).to match(/<strong>Certificate<\/strong>: #{programme.title}/)
        end
      end

      context 'when filtering by subject' do
        before do
          get courses_path, params: { topic: 'Mathematics' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(4)
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
          expect(assigns(:courses).count).to eq(10)
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
          expect(assigns(:courses).count).to eq(22)
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
          expect(assigns(:courses).count).to eq(15)
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
          expect(assigns(:courses).count).to eq(28)
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

      context 'when filtering by level and location' do
        before do
          get courses_path, params: { level: 'Key stage 4', location: 'York' }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(6)
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
          expect(assigns(:courses).count).to eq(21)
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
          expect(assigns(:courses).count).to eq(6)
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

      context 'filter by level, location, and topic' do
        before do
          programme
          get courses_path, params: {
            level: 'Key stage 4',
            topic: 'Computing',
            location: 'York'
          }
        end

        it 'has correct number of courses' do
          expect(assigns(:courses).count).to eq(6)
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
          expect(flash[:notice]).to match(/&lt;p&gt;My XSS is excessive&lt;\/p&gt;/)
        end

        it 'topic param is escaped' do
          expect(flash[:notice]).to match(/&lt;script&gt;alert\(&quot;boom&quot;\)&lt;\/script&gt;/)
        end

        it 'location param is escaped' do
          expect(flash[:notice]).to match(/&lt;svg onload=alert\(1\)&gt;/)
        end

        it 'invalid certificate does not cause filtering' do
          expect(flash[:notice]).not_to match(/&lt;h1&gt;Not a cert&lt;\/h1&gt;/)
        end
      end
    end
  end
end
