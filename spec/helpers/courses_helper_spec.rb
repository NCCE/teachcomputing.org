require 'rails_helper'

describe CoursesHelper, type: :helper do
  describe('#activity_address') do
    it 'rejects blank attributes' do
      course = instance_double('course', address_venue_name: 'Example',
                                         address_line_1: 'Line 1',
                                         address_line_2: 'Line 2',
                                         address_line_3: 'Line 3',
                                         address_line_4: '',
                                         address_town: 'Town'
        )

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

      expect(helper.activity_times(start_time, end_time)).to eq '09:00 - 16:00'
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

  describe('course_meta_css_class') do
    it 'returns icon for offline courses' do
      expect(helper.course_meta_css_class(0)).to eq 'ncce-courses__meta-icon'
    end

    it 'returns icon for online courses' do
      expect(helper.course_meta_css_class(1)).to eq 'ncce-courses__meta-icon ncce-courses__meta-icon--online'
    end
  end
end
