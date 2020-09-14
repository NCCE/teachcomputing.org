require 'rails_helper'

describe CoursesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:activity_two) { create(:activity) }
  let(:achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }

  let(:courses) do
    (0..10).map do |i|
      instance_double('course', course_template_no: i.to_s)
    end
  end

  let(:course) do
    instance_double('course', course_template_no: '1',
                              address_venue_name: 'Example',
                              address_line_1: 'Line 1',
                              address_line_2: 'Line 2',
                              address_line_3: 'Line 3',
                              address_line_4: '',
                              address_town: 'Town')
  end

  let(:programme) do
    programme = create(:programme)
    (0..5).each do |i|
      activity = create(:activity, category: 'online', stem_course_template_no: i.to_s)
      programme.activities << activity
    end

    (6..12).each do |i|
      activity = create(:activity, category: 'face-to-face', stem_course_template_no: i.to_s)
      programme.activities << activity
    end
    programme
  end

  describe('#activity_address') do
    it 'rejects blank attributes' do
      expect(helper.activity_address(course).scan(/<br>/).length).to eq 4
    end
  end

  describe('#activity_booking_url') do
    context 'when booking_url is blank' do
      it 'returns nil' do
        expect(helper.activity_booking_url('')).to eq nil
      end
    end

    it 'returns a link' do
      booking_url = 'https://example.com/booking_link'

      expect(helper.activity_booking_url(booking_url)).to include 'https://example.com/booking_link'
    end
  end

  describe('#activity_dates') do
    it 'returns the dates in the correct format' do
      start_date = '01/11/2018'
      end_date = '11/11/2018'

      expect(helper.activity_dates(start_date, end_date)).to eq '1 November—11 November 2018'
    end
  end

  describe('#activity_times') do
    it 'returns the times in the correct format' do
      start_time = '1900-01-01T09:00:00+00:00'
      end_time = '1900-01-01T16:00:00+00:00'

      expect(helper.activity_times(start_time, end_time)).to eq '1 January 09:00—1 January 1900'
    end

    it 'returns the activity_dates if we ask for dates_only' do
      start_time = '1900-01-01T09:00:00+00:00'
      end_time = '1900-01-01T16:00:00+00:00'

      expect(helper.activity_times(start_time, end_time, true)).to eq '1 January—1 January 1900'
    end
  end

  describe('#stem_course_link') do
    it 'returns the link to the course page on stem.org.uk' do
      expect(helper.stem_course_link('01de2624')).to eq "#{ENV.fetch('STEM_OAUTH_SITE')}/cpdredirect/01de2624"
    end
  end

  describe('stripped_summary') do
    it 'removes any html elements in the string' do
      expect(helper.stripped_summary('<p>Hello</p>')).to eq 'Hello'
    end
  end

  describe('course_meta_icon_class') do
    it 'returns icon for offline courses' do
      expect(helper.course_meta_icon_class(false)).to eq 'icon-map-pin'
    end

    it 'returns icon for online courses' do
      expect(helper.course_meta_icon_class(true)).to eq 'icon-online'
    end
  end

  describe('#online_course_date') do
    it 'returns Join Now when it is in the present' do
      expect(helper.online_course_date(DateTime.now.change(year: 2021).to_s)).to include 'Register now'
    end

    it 'returns register when it is in the future' do
      expect(helper.online_course_date(DateTime.now.to_s)).to eq 'Join now'
    end
  end

  describe('user_achievement_state') do
    it 'throws error if user is not supplied' do
      expect { helper.user_achievement_state(nil, activity) }.to raise_error(NoMethodError)
    end

    it 'returns not_enrolled if activity is not supplied' do
      expect(helper.user_achievement_state(user, nil)).to eq :not_enrolled
    end

    it 'returns not_enrolled for no achievement' do
      expect(helper.user_achievement_state(user, activity_two)).to eq :not_enrolled
    end

    it 'returns enrolled if achievement is not complete' do
      achievement
      expect(helper.user_achievement_state(user, activity)).to eq :enrolled
    end

    it 'returns complete if achievement is complete' do
      achievement.set_to_complete
      expect(helper.user_achievement_state(user, activity)).to eq :complete
    end
  end

  describe('other_courses_on_programme') do
    it 'throws error if courses is not passed' do
      expect { other_courses_on_programme(nil, course, programme, 3) }
        .to raise_error(NoMethodError)
    end

    it 'throws error if programme is not passed' do
      expect { other_courses_on_programme(courses, course, nil, 3) }
        .to raise_error(NoMethodError)
    end

    it 'throws error if course is not passed' do
      expect { other_courses_on_programme(courses, nil, programme, 3) }
        .to raise_error(NoMethodError)
    end

    it 'returns 3 courses by default' do
      expect(other_courses_on_programme(courses, course, programme).count).to eq(3)
    end

    it 'returns N courses when specified' do
      expect(other_courses_on_programme(courses, course, programme, 5).count).to eq(5)
    end

    it 'courses do not include the course passed in' do
      other_courses = other_courses_on_programme(courses, course, programme, 6)
      expect(other_courses.include?(course)).to eq(false)
    end

    it 'courses include the next 6 courses' do
      other_courses = other_courses_on_programme(courses, course, programme, 5).map(&:course_template_no)
      %w[0 2 3 4 5].each { |id| expect(other_courses.include?(id)).to eq(true) }
    end
  end

  describe('sanitize_stem_html') do
    it 'does not allow empty nodes with non-breaking-spaces' do
      expect(helper.sanitize_stem_html('<p>&nbsp;</p>')).to eq ''
    end

    it 'allows unordered lists' do
      list = '<ul><li>One</li><li>Two</li></ul>'
      expect(helper.sanitize_stem_html(list).gsub(/\s/, '')).to eq list
    end

    it 'allows ordered lists' do
      list = '<ol><li>One</li><li>Two</li></ol>'
      expect(helper.sanitize_stem_html(list).gsub(/\s/, '')).to eq list
    end

    it 'allows headings' do
      headings = '<h1>One</h1><h2>Two</h2><h3>Three</h3><h4>Four</h4>'
      expect(helper.sanitize_stem_html(headings)).to eq headings
    end

    it 'disallows images' do
      image = '<p><img src="abc.jpg"/>Image</p>'
      expect(helper.sanitize_stem_html(image)).to eq '<p>Image</p>'
    end

    it 'allows links' do
      link = '<p><a href="abc.html">Link</a></p>'
      expect(helper.sanitize_stem_html(link)).to eq link
    end

    it 'disallows inline styles' do
      style = '<p style="font-family: Courier;color: f00;">Fancy text</p>'
      expect(helper.sanitize_stem_html(style)).to eq '<p>Fancy text</p>'
    end

    it 'disallows class attributes' do
      class_attr = '<p class="govuk-body-m">Simple text</p>'
      expect(helper.sanitize_stem_html(class_attr)).to eq '<p>Simple text</p>'
    end

    it 'allows video markup' do
      video = '<video poster="image.jpg"
                  controls="true" playsinline="true" crossorigin="anonymous"
                  preload="none" tabindex="-1"
                  src="/Videos/video.mp4">
                  <source src="/Videos/video.mp4"
                    type="video/mp4"></source>
                  <track class="track"
                    src="/Videos/captions.vtt" kind="captions"
                    srclang="EN" label="English"></track>
                </video>'

      expect(helper.sanitize_stem_html(video).gsub(/\s/, '')).to eq video.to_s.gsub(/\s/, '')
    end
  end

  describe 'course_subtitle_text' do
    it 'returns remote correctly' do
      course = instance_double('course', online_cpd: false, remote_delivered_cpd: true)
      expect(helper.course_subtitle_text(course)).to eq('Remote')
    end

    it 'returns online correctly' do
      course = instance_double('course', online_cpd: true, remote_delivered_cpd:
                              false)
      expect(helper.course_subtitle_text(course)).to eq('Online')
    end

    it 'returns face to face correctly' do
      course = instance_double('course', online_cpd: false, remote_delivered_cpd:
                              false)
      expect(helper.course_subtitle_text(course)).to eq('Face to face')
    end
  end

  describe 'remote_or_face_to_face' do
    it 'returns remote correctly' do
      course = instance_double('course', remote_delivered_cpd: true)
      expect(helper.remote_or_face_to_face(course)).to eq('Remote')
    end

    it 'returns face to face correctly' do
      course = instance_double('course', remote_delivered_cpd: false)
      expect(helper.remote_or_face_to_face(course)).to eq('Face to face')
    end
  end
end
