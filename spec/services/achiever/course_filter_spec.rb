require 'rails_helper'

RSpec.describe Achiever::CourseFilter do
  subject(:course_filter) { described_class.new(filter_params: filter_params) }

  let(:subjects) do
    { 'Algorithms' => '111111111', 'Other' => '222222222',
      'Unused subject' => '333333333' }
  end
  let(:filter_params) { {} }
  let(:age_groups) { { 'Key stage 1' => '111111111', 'Key stage 2' => '222222222' } }

  let(:f2f_template) { build(:achiever_course_template, title: 'F2F template', subjects: [subjects['Other']]) }
  let(:f2f_occurrence) do
    build(:achiever_course_occurrence, course_template_no: f2f_template.course_template_no, distance: 10)
  end
  let(:online_template) { build(:achiever_course_template, title: 'Online template', online_cpd: true) }
  let(:online_occurrence) do
    build(:achiever_course_occurrence, online_cpd: true, course_template_no: online_template.course_template_no)
  end
  let(:no_occ_template) { build(:achiever_course_template, title: 'No occurrence template') }
  let(:secondary_template) { build(:achiever_course_template, programmes: ['Secondary'], title: 'Secondary template') }
  let(:secondary_occurrence) do
    build(:achiever_course_occurrence, course_template_no: secondary_template.course_template_no, distance: 50)
  end
  let(:ks2_template) do
    build(:achiever_course_template, age_groups: [age_groups['Key stage 2']], title: 'KS2 template')
  end
  let(:ks2_occurrence) do
    build(:achiever_course_occurrence, course_template_no: ks2_template.course_template_no, distance: 80)
  end
  let(:location_template) { build(:achiever_course_template, remote_delivered_cpd: true, title: 'Location template') }
  let(:location_occurrence_matching_location) do
    build(:achiever_course_occurrence,
          course_template_no: location_template.course_template_no,
          address_town: 'York',
          distance: 90)
  end
  let(:location_occurrence_other_location) do
    build(:achiever_course_occurrence,
          course_template_no: location_template.course_template_no,
          address_town: 'Cambridge',
          distance: 20)
  end
  let(:algorithms_template) do
    build(:achiever_course_template, subjects: [subjects['Algorithms']], title: 'Algorithms template')
  end
  let(:algorithms_occurrence) do
    build(:achiever_course_occurrence, course_template_no: algorithms_template.course_template_no, distance: 30)
  end

  let(:multi_filter_template) do
    build(:achiever_course_template,
          subjects: [subjects['Algorithms']],
          remote_delivered_cpd: true,
          title: 'Multi filter template',
          age_groups: [age_groups['Key stage 2']])
  end
  let(:multi_filter_occurrence) do
    build(:achiever_course_occurrence, course_template_no: multi_filter_template.course_template_no, distance: 70)
  end

  let(:hub_template) { build(:achiever_course_template, title: 'Hub template') }
  let(:hub_occurrence_matching_hub) do
    build(:achiever_course_occurrence,
          course_template_no: hub_template.course_template_no,
          hub_id: 'hubid',
          hub_name: 'Hub name',
          distance: 40)
  end
  let(:hub_occurrence_other_hub) do
    build(:achiever_course_occurrence,
          course_template_no: hub_template.course_template_no,
          hub_id: 'otherhubid',
          hub_name: 'Other hub name',
          distance: 60)
  end

  before do
    allow(Achiever::Course::Subject).to receive(:all).and_return(subjects)
    allow(Achiever::Course::AgeGroup).to receive(:all).and_return(age_groups)

    # return courses sorted alphabetically by title same way the achiever does
    allow(Achiever::Course::Template)
      .to receive(:all)
      .and_return([
                    algorithms_template,
                    f2f_template,
                    hub_template,
                    ks2_template,
                    location_template,
                    multi_filter_template,
                    no_occ_template,
                    online_template,
                    secondary_template
                  ])
    allow(Achiever::Course::Occurrence)
      .to receive(:face_to_face)
      .and_return([f2f_occurrence, secondary_occurrence, ks2_occurrence,
                   location_occurrence_other_location, location_occurrence_matching_location,
                   algorithms_occurrence, multi_filter_occurrence, hub_occurrence_other_hub, hub_occurrence_matching_hub])
    allow(Achiever::Course::Occurrence)
      .to receive(:online)
      .and_return([online_occurrence])
    create(:secondary_certificate)
  end

  describe '#subjects' do
    it 'returns all achiever subjects' do
      expect(course_filter.subjects).to eq(subjects)
    end
  end

  describe '#age_groups' do
    it 'returns all achiever age groups' do
      expect(course_filter.age_groups).to eq(age_groups)
    end
  end

  describe '#current_certificate' do
    context 'when not filtering by certificate' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '' } }

      it 'returns nil' do
        expect(course_filter.current_certificate).to eq(nil)
      end
    end

    context 'when filtering by certificate' do
      let(:filter_params) { { certificate: 'secondary-certificate', level: '', location: '', topic: '' } }

      it 'returns the certificate' do
        expect(course_filter.current_certificate).to eq(Programme.secondary_certificate.slug)
      end
    end
  end

  describe '#current_topic' do
    context 'when not filtering by topic' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '' } }

      it 'returns nil' do
        expect(course_filter.current_topic).to eq(nil)
      end
    end

    context 'when filtering by topic' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: 'Algorithms' } }

      it 'returns the topic' do
        expect(course_filter.current_topic).to eq('Algorithms')
      end
    end
  end

  describe '#current_location' do
    context 'when not filtering by location' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '' } }

      it 'returns nil' do
        expect(course_filter.current_location).to eq(nil)
      end
    end

    context 'when filtering by location' do
      let(:filter_params) { { certificate: '', level: '', location: 'York', topic: '' } }

      it 'returns the location' do
        expect(course_filter.current_location).to eq('York')
      end
    end
  end

  describe '#current_level' do
    context 'when not filtering by level' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '' } }

      it 'returns nil' do
        expect(course_filter.current_level).to eq(nil)
      end
    end

    context 'when filtering by level' do
      let(:filter_params) { { certificate: '', level: 'Key stage 2', location: '', topic: '' } }

      it 'returns the level' do
        expect(course_filter.current_level).to eq('Key stage 2')
      end
    end
  end

  describe '#current_hub' do
    context 'when not filtering by hub' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', hub_id: '' } }

      it 'returns nil' do
        expect(course_filter.current_hub).to eq(nil)
      end
    end

    context 'when filtering by hub with occurrences' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', hub_id: 'hubid' } }

      it 'returns the hub name from the occurrences' do
        expect(course_filter.current_hub).to eq('Hub name')
      end
    end

    context 'when filtering by hub with no occurrences' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', hub_id: 'nooccurrenceshubid' } }

      it 'returns :no_courses' do
        expect(course_filter.current_hub).to eq(:no_courses)
      end
    end
  end

  describe '#course_format' do
    context 'when not filtering by course format' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', course_format: '' } }

      it 'returns nil' do
        expect(course_filter.current_format).to eq(nil)
      end
    end

    context 'when filtering by course format' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', course_format: %w[online remote] } }

      it 'returns the course format' do
        expect(course_filter.current_format).to eq(%w[online remote])
      end
    end
  end

  describe '#course_tags' do
    it 'returns subjects present on courses' do
      expect(course_filter.course_tags).to eq({ 'Algorithms' => '111111111', 'Other' => '222222222' })
    end

    context 'when filtering' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: 'Algorithms' } }

      it 'returns subjects present on all courses, not just filtered courses' do
        expect(course_filter.course_tags).to eq({ 'Algorithms' => '111111111', 'Other' => '222222222' })
      end
    end
  end

  describe '#non_location_search_results' do
    context 'when no filters are present' do
      it 'returns all achiever courses and their occurrences if present' do
        expect(f2f_template.occurrences).to eq([])
        expect(online_template.occurrences).to eq([])
        expect(secondary_template.occurrences).to eq([])
        expect(ks2_template.occurrences).to eq([])
        expect(course_filter.non_location_search_results)
          .to match_array(
            [
              f2f_template,
              online_template,
              location_template,
              ks2_template,
              algorithms_template,
              multi_filter_template,
              hub_template,
              secondary_template,
              no_occ_template
            ]
          )
        expect(f2f_template.occurrences).to eq([f2f_occurrence])
        expect(online_template.occurrences).to eq([online_occurrence])
        expect(secondary_template.occurrences).to eq([secondary_occurrence])
        expect(ks2_template.occurrences).to eq([ks2_occurrence])
        expect(location_template.occurrences)
          .to match_array(
            [
              location_occurrence_matching_location,
              location_occurrence_other_location
            ]
          )
        expect(algorithms_template.occurrences).to eq([algorithms_occurrence])
        expect(multi_filter_template.occurrences).to eq([multi_filter_occurrence])
        expect(hub_template.occurrences)
          .to match_array(
            [
              hub_occurrence_matching_hub,
              hub_occurrence_other_hub
            ]
          )
      end
    end

    context 'when filtering by certificate' do
      let(:filter_params) { { certificate: 'secondary-certificate', level: '', location: '', topic: '' } }

      it 'only returns courses for correct certificate' do
        expect(course_filter.non_location_search_results)
          .to match_array([secondary_template])
      end
    end

    context 'when filtering by level' do
      let(:filter_params) { { certificate: '', level: 'Key stage 2', location: '', topic: '' } }

      it 'returns courses with correct level' do
        expect(course_filter.non_location_search_results)
          .to match_array([ks2_template, multi_filter_template])
      end
    end

    context 'when filtering by location' do
      let(:filter_params) { { certificate: '', level: '', location: 'York', topic: '' } }

      it 'returns courses for correct location with all their occurrences' do
        expect(course_filter.non_location_search_results)
          .to match_array([location_template])
        expect(location_template.occurrences).to include(location_occurrence_matching_location)
        expect(location_template.occurrences).to include(location_occurrence_other_location)
      end
    end

    context 'when filtering by online' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', course_format: %w[online] } }

      it 'returns only courses with online_cpd true' do
        expect(course_filter.non_location_search_results)
          .to match_array([online_template])
      end
    end

    context 'when filtering by face to face' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', course_format: %w[face_to_face] } }

      it 'returns courses with online_cpd false and remote_delivered_cpd false' do
        expect(course_filter.non_location_search_results)
          .to match_array([f2f_template,
                           ks2_template,
                           algorithms_template,
                           hub_template,
                           secondary_template,
                           no_occ_template])
      end
    end

    context 'when filtering by remote' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: '', course_format: %w[remote] } }

      it 'returns courses with remote_delivered_cpd true' do
        expect(course_filter.non_location_search_results).to match_array([location_template, multi_filter_template])
      end
    end

    context 'when filtering by multiple formats' do
      let(:filter_params) do
        { certificate: '', level: '', location: '', topic: '', course_format: %w[face_to_face online] }
      end

      it 'only returns courses for correct topic' do
        expect(course_filter.courses).to match_array([
                                                       f2f_template,
                                                       ks2_template,
                                                       algorithms_template,
                                                       hub_template,
                                                       secondary_template,
                                                       no_occ_template,
                                                       online_template
                                                     ])
      end
    end

    context 'when filtering by topic' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: 'Algorithms' } }

      it 'only returns courses for correct topic' do
        expect(course_filter.non_location_search_results).to match_array([algorithms_template, multi_filter_template])
      end
    end

    context 'when filtering by level, location and topic' do
      let(:filter_params) do
        { certificate: '', location: '', level: 'Key stage 2', topic: 'Algorithms', course_format: %w[remote] }
      end

      it 'returns courses which match all criteria' do
        expect(course_filter.non_location_search_results).to match_array([multi_filter_template])
      end
    end

    context 'when filtering by hub' do
      let(:filter_params) { { hub_id: 'hubid', certificate: '', level: '', location: '', topic: '' } }

      it 'only returns courses with occurrences at the correct hub' do
        expect(course_filter.non_location_search_results).to match_array([hub_template])
      end

      it 'only returns occurrences for the correct hub' do
        course = course_filter.non_location_search_results.first
        expect(course.occurrences).to include(hub_occurrence_matching_hub)
        expect(course.occurrences).not_to include(hub_occurrence_other_hub)
      end
    end

    context 'when using search location' do
      let(:filter_params) { { search_location: 'Liverpool' } }

      it 'returns only remote and online courses' do
        puts course_filter.non_location_search_results.map(&:title)
        expect(course_filter.non_location_search_results)
          .to match_array(
            [
              online_template,
              location_template,
              multi_filter_template
            ]
          )
      end
    end
  end

  describe '#location_search_results' do
    let(:result_dbl) { double('result') }

    before do
      allow(Geocoder).to receive(:search) { [result_dbl] }
      allow(result_dbl).to receive(:coordinates).and_return([53.41058, -2.97794])
    end

    context 'when not searching by location' do
      it 'returns nil' do
        expect(course_filter.location_search_results).to eq(nil)
      end
    end

    context 'when searching by location' do
      let(:filter_params) { { search_location: 'Liverpool' } }

      it 'returns f2f courses ordered by nearest occurrences within default radius' do
        expect(course_filter.location_search_results)
          .to eq([f2f_template,
                  algorithms_template,
                  hub_template])
      end

      it 'orders course occurrences by distance for each course' do
        course_filter.location_search_results
        expect(hub_template.occurrences)
          .to eq(
            [
              hub_occurrence_matching_hub,
              hub_occurrence_other_hub
            ]
          )
      end
    end

    context 'when searching by location and radius' do
      let(:filter_params) { { search_location: 'Liverpool', radius: '60' } }

      it 'returns f2f courses ordered by nearest occurrences within defined radius' do
        expect(course_filter.location_search_results)
          .to eq([f2f_template,
                  algorithms_template,
                  hub_template,
                  secondary_template])
      end
    end
  end

  describe '#applied_filters' do
    context 'when no filters are present' do
      it 'returns nil' do
        expect(course_filter.applied_filters).to eq(nil)
      end
    end

    context 'when filtering by certificate' do
      let(:filter_params) { { certificate: 'secondary-certificate', level: '', location: '', topic: '' } }

      it 'returns current certificate' do
        expect(course_filter.applied_filters).to match_array(['secondary-certificate'])
      end
    end

    context 'when filtering by level' do
      let(:filter_params) { { certificate: '', level: 'Key stage 2', location: '', topic: '' } }

      it 'returns current level' do
        expect(course_filter.applied_filters).to match_array(['Key stage 2'])
      end
    end

    context 'when filtering by location' do
      let(:filter_params) { { certificate: '', level: '', location: 'York', topic: '' } }

      it 'returns current location' do
        expect(course_filter.applied_filters).to match_array(['York'])
      end
    end

    context 'when filtering by online' do
      let(:filter_params) { { certificate: '', level: '', course_format: 'online', topic: '' } }

      it 'returns online string' do
        expect(course_filter.applied_filters).to match_array(['online'])
      end
    end

    context 'when filtering by face to face' do
      let(:filter_params) { { certificate: '', level: '', course_format: 'face_to_face', topic: '' } }

      it 'returns face to face string' do
        expect(course_filter.applied_filters).to match_array(['face_to_face'])
      end
    end

    context 'when filtering by remote' do
      let(:filter_params) { { certificate: '', level: '', course_format: 'remote', topic: '' } }

      it 'returns remote string' do
        expect(course_filter.applied_filters).to match_array(['remote'])
      end
    end

    context 'when filtering by topic' do
      let(:filter_params) { { certificate: '', level: '', location: '', topic: 'Algorithms' } }

      it 'returns topic' do
        expect(course_filter.applied_filters).to match_array(['Algorithms'])
      end
    end

    context 'when filtering by hub' do
      let(:filter_params) { { hub_id: 'hubid', certificate: '', level: '', location: '', topic: '' } }

      it 'returns current_hub' do
        expect(course_filter.applied_filters).to match_array([course_filter.current_hub])
      end
    end

    context 'when filtering by all options' do
      let(:filter_params) do
        { certificate: 'secondary-certificate', course_format: %w[remote face_to_face], level: 'Key stage 2', topic: 'Algorithms',
          hub_id: 'hubid' }
      end

      it 'returns all strings' do
        expect(course_filter.applied_filters)
          .to match_array(
            [
              course_filter.current_hub,
              'secondary-certificate',
              'Algorithms',
              'Key stage 2',
              '[&quot;remote&quot;, &quot;face_to_face&quot;]'
            ]
          )
      end
    end

    context 'when provided with values that need escaping' do
      let(:filter_params) do
        {
          certificate: '<h1>Not a cert</h1>',
          level: '<p>My XSS is excessive</p>',
          topic: '<script>alert("boom")</script>',
          location: '<svg onload=alert(1)>'
        }
      end

      it 'level param is escaped' do
        expect(course_filter.applied_filters).to include(%r{&lt;p&gt;My XSS is excessive&lt;/p&gt;})
      end

      it 'topic param is escaped' do
        expect(course_filter.applied_filters)
          .to include(%r{&lt;script&gt;alert\(&quot;boom&quot;\)&lt;/script&gt;})
      end

      it 'location param is escaped' do
        expect(course_filter.applied_filters).to include(/&lt;svg onload=alert\(1\)&gt;/)
      end

      it 'certificate param is escaped' do
        expect(course_filter.applied_filters).to include(%r{&lt;h1&gt;Not a cert&lt;/h1&gt;})
      end
    end
  end

  describe '#location_search?' do
    context 'when search_location param present' do
      let(:filter_params) { { search_location: 'liverpool' } }

      it 'returns true' do
        expect(course_filter.location_search?).to eq(true)
      end
    end

    context 'when search_location param empty' do
      let(:filter_params) { { search_location: '' } }

      it 'returns false' do
        expect(course_filter.location_search?).to eq(false)
      end
    end
  end

  describe '#search_location_formatted_address' do
    let(:result_dbl) { double('result') }

    context 'when geocoded location is found' do
      before do
        allow(Geocoder).to receive(:search) { [result_dbl] }
      end

      let(:filter_params) { { search_location: 'liverpool' } }

      it 'returns the address from geocoding result' do
        allow(result_dbl).to receive(:formatted_address).and_return('Liverpool, UK')
        expect(course_filter.search_location_formatted_address).to eq('Liverpool, UK')
      end

      context 'when geocoded location is not found' do
        before do
          allow(Geocoder).to receive(:search).and_return([])
        end

        let(:filter_params) { { search_location: 'asdfasdfasdfasdf' } }

        it 'returns the not found message' do
          expect(course_filter.search_location_formatted_address).to eq('This location was not recognised. Please check if it is correct.')
        end
      end
    end
  end

  describe '#search_radius' do
    let(:filter_params) { {} }

    it 'returns 40 by default' do
      expect(course_filter.search_radius).to eq('40')
    end

    context 'when radius present in params' do
      let(:filter_params) { { radius: '50' } }

      it 'returns value set by params' do
        expect(course_filter.search_radius).to eq('50')
      end
    end
  end
end
