require "rails_helper"

describe CoursesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:activity) { create(:activity) }
  let(:activity_two) { create(:activity) }
  let(:achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }
  let(:course_template) { Achiever::Course::Template.find_by_activity_code("CP428") }

  let(:courses) do
    (0..10).map do |i|
      instance_double("course", course_template_no: i.to_s)
    end
  end

  let(:course) do
    instance_double("course", course_template_no: "1",
      address_venue_name: "Example",
      address_line_1: "Line 1",
      address_line_2: "Line 2",
      address_line_3: "Line 3",
      address_line_4: "",
      address_town: "Town",
      online_cpd: false,
      remote_delivered_cpd: false)
  end

  let(:programme) do
    programme = create(:programme)
    6.times do |i|
      activity = create(:activity, category: "online", stem_course_template_no: i.to_s)
      programme.activities << activity
    end

    (6..12).each do |i|
      activity = create(:activity, category: "face-to-face", stem_course_template_no: i.to_s)
      programme.activities << activity
    end
    programme
  end

  describe("#activity_address") do
    it "rejects blank attributes" do
      expect(helper.activity_address(course).scan("<br>").length).to eq 4
    end
  end

  describe("#activity_booking_url") do
    context "when booking_url is blank" do
      it "returns nil" do
        expect(helper.activity_booking_url("")).to eq nil
      end
    end

    it "returns a link" do
      booking_url = "https://example.com/booking_link"

      expect(helper.activity_booking_url(booking_url)).to include "https://example.com/booking_link"
    end
  end

  describe("#activity_dates") do
    it "returns the dates in the correct format" do
      start_date = "01/11/2018"
      end_date = "11/11/2018"

      expect(helper.activity_dates(start_date, end_date)).to eq "1 November—11 November 2018"
    end
  end

  describe("#activity_times") do
    it "returns the times in the correct format" do
      start_time = "1900-01-01T09:00:00+00:00"
      end_time = "1900-01-01T16:00:00+00:00"

      expect(helper.activity_times(start_time, end_time)).to eq "1 January 09:00—1 January 1900"
    end

    it "returns the activity_dates if we ask for dates_only" do
      start_time = "1900-01-01T09:00:00+00:00"
      end_time = "1900-01-01T16:00:00+00:00"

      expect(helper.activity_times(start_time, end_time, true)).to eq "1 January—1 January 1900"
    end
  end

  describe("#stem_course_link") do
    it "returns the link to the course page on stem.org.uk" do
      expect(helper.stem_course_link("01de2624")).to eq "#{ENV.fetch("STEM_COURSE_REDIRECT")}/cpdredirect/01de2624"
    end
  end

  describe("stripped_summary") do
    it "removes any html elements in the string" do
      expect(helper.stripped_summary("<p>Hello</p>")).to eq "Hello"
    end
  end

  describe("course_meta_icon_class") do
    it "returns icon for offline courses" do
      expect(helper.course_meta_icon_class(course)).to eq "icon-map-pin"
    end

    it "returns icon for remote courses" do
      remote_course = instance_double("course", online_cpd: false, remote_delivered_cpd: true)
      expect(helper.course_meta_icon_class(remote_course)).to eq "icon-remote"
    end

    it "returns icon for online courses" do
      online_course = instance_double("course", online_cpd: true, remote_delivered_cpd: false)
      expect(helper.course_meta_icon_class(online_course)).to eq "icon-online"
    end
  end

  describe("occurrence_meta_location") do
    it "returns address_town for offline occurrences" do
      occurrence = build(:achiever_course_occurrence, address_town: "Hastings")
      expect(helper.occurrence_meta_location(occurrence)).to eq("Hastings")
    end

    it 'returns "Live remote training" for remote occurrences' do
      remote_occurrence = build(:achiever_course_occurrence, remote_delivered_cpd: true)
      expect(helper.occurrence_meta_location(remote_occurrence)).to eq("Live remote training")
    end

    it "returns icon for online occurrences" do
      online_occurrence = build(:achiever_course_occurrence, online_cpd: true)
      expect(helper.occurrence_meta_location(online_occurrence)).to eq("Free online course")
    end
  end

  describe("#online_course_availability") do
    it "formats a start date" do
      expect(helper.online_course_availability(DateTime.new(3020, 10, 1)))
        .to eq("Available from 01 October 3020.")
    end
  end

  describe "#started?" do
    it "is true on start date" do
      Timecop.freeze(2023, 12, 31) do
        expect(helper.started?("31/12/2023 00:00:00")).to be(true)
      end
    end

    it "is false before start date" do
      Timecop.freeze(2023, 12, 30) do
        expect(helper.started?("31/12/2023 00:00:00")).to be(false)
      end
    end
  end

  describe("user_achievement_state") do
    it "throws error if user is not supplied" do
      expect { helper.user_achievement_state(nil, activity) }.to raise_error(NoMethodError)
    end

    it "returns not_enrolled if activity is not supplied" do
      expect(helper.user_achievement_state(user, nil)).to eq :not_enrolled
    end

    it "returns not_enrolled for no achievement" do
      expect(helper.user_achievement_state(user, activity_two)).to eq :not_enrolled
    end

    it "returns enrolled if achievement is not complete" do
      achievement
      expect(helper.user_achievement_state(user, activity)).to eq :enrolled
    end

    it "returns complete if achievement is complete" do
      achievement.complete!
      expect(helper.user_achievement_state(user, activity)).to eq :complete
    end

    it "returns :dropped if achievement is in state dropped" do
      achievement.transition_to(:dropped)
      expect(helper.user_achievement_state(user, activity)).to eq :dropped
    end
  end

  describe("other_courses_on_programme") do
    it "throws error if courses is not passed" do
      expect { other_courses_on_programme(nil, course, programme, 3) }
        .to raise_error(NoMethodError)
    end

    it "throws error if programme is not passed" do
      expect { other_courses_on_programme(courses, course, nil, 3) }
        .to raise_error(NoMethodError)
    end

    it "throws error if course is not passed" do
      expect { other_courses_on_programme(courses, nil, programme, 3) }
        .to raise_error(NoMethodError)
    end

    it "returns 3 courses by default" do
      expect(other_courses_on_programme(courses, course, programme).count).to eq(3)
    end

    it "returns N courses when specified" do
      expect(other_courses_on_programme(courses, course, programme, 5).count).to eq(5)
    end

    it "courses do not include the course passed in" do
      other_courses = other_courses_on_programme(courses, course, programme, 6)
      expect(other_courses.include?(course)).to eq(false)
    end

    it "courses include the next 6 courses" do
      other_courses = other_courses_on_programme(courses, course, programme, 5).map(&:course_template_no)
      %w[0 2 3 4 5].each { |id| expect(other_courses.include?(id)).to eq(true) }
    end
  end

  describe("sanitize_stem_html") do
    it "does not allow empty nodes with non-breaking-spaces" do
      expect(helper.sanitize_stem_html("<p>&nbsp;</p>")).to eq ""
    end

    it "allows unordered lists" do
      list = "<ul><li>One</li><li>Two</li></ul>"
      expect(helper.sanitize_stem_html(list).gsub(/\s/, "")).to eq list
    end

    it "allows ordered lists" do
      list = "<ol><li>One</li><li>Two</li></ol>"
      expect(helper.sanitize_stem_html(list).gsub(/\s/, "")).to eq list
    end

    it "allows headings" do
      headings = "<h1>One</h1><h2>Two</h2><h3>Three</h3><h4>Four</h4>"
      expect(helper.sanitize_stem_html(headings)).to eq headings
    end

    it "disallows images" do
      image = '<p><img src="abc.jpg"/>Image</p>'
      expect(helper.sanitize_stem_html(image)).to eq "<p>Image</p>"
    end

    it "allows links" do
      link = '<p><a href="abc.html">Link</a></p>'
      expect(helper.sanitize_stem_html(link)).to eq link
    end

    it "disallows inline styles" do
      style = '<p style="font-family: Courier;color: f00;">Fancy text</p>'
      expect(helper.sanitize_stem_html(style)).to eq "<p>Fancy text</p>"
    end

    it "disallows class attributes" do
      class_attr = '<p class="govuk-body-m">Simple text</p>'
      expect(helper.sanitize_stem_html(class_attr)).to eq "<p>Simple text</p>"
    end

    it "allows video markup" do
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

      expect(helper.sanitize_stem_html(video).gsub(/\s/, "")).to eq video.to_s.gsub(/\s/, "")
    end
  end

  describe "course_subtitle_text" do
    it "returns remote correctly" do
      course = instance_double("course", online_cpd: false, remote_delivered_cpd: true)
      expect(helper.course_subtitle_text(course)).to eq("Live remote training course")
    end

    it "returns online correctly" do
      course = instance_double("course", online_cpd: true, remote_delivered_cpd:
                              false)
      expect(helper.course_subtitle_text(course)).to eq("Online course")
    end

    it "returns face to face correctly" do
      course = instance_double("course", online_cpd: false, remote_delivered_cpd:
                              false)
      expect(helper.course_subtitle_text(course)).to eq("Face to face course")
    end
  end

  describe "course_type" do
    it "returns remote correctly" do
      course = instance_double("course", online_cpd: false, remote_delivered_cpd: true)
      expect(helper.course_type(course)).to eq("Live remote training")
    end

    it "returns online correctly" do
      course = instance_double("course", online_cpd: true, remote_delivered_cpd:
                              false)
      expect(helper.course_type(course)).to eq("Free online course")
    end

    it "returns face to face correctly" do
      course = instance_double("course", online_cpd: false, remote_delivered_cpd:
                              false)
      expect(helper.course_type(course)).to eq("Face to face")
    end
  end

  describe "remote_or_face_to_face" do
    it "returns remote correctly" do
      course = instance_double("course", remote_delivered_cpd: true)
      expect(helper.remote_or_face_to_face(course)).to eq("Live remote training")
    end

    it "returns face to face correctly" do
      course = instance_double("course", remote_delivered_cpd: false)
      expect(helper.remote_or_face_to_face(course)).to eq("Face to face")
    end
  end

  describe "view_course_phrase" do
    it "returns correctly for remote courses" do
      course = instance_double("course", remote_delivered_cpd: true)
      expect(helper.view_course_phrase(course)).to eq("View dates")
    end

    it "returns correctly for non remote courses" do
      course = instance_double("course", remote_delivered_cpd: false, online_cpd: false)
      expect(helper.view_course_phrase(course)).to eq("View locations and dates")
    end

    it "returns correctly for online courses" do
      course = instance_double("course", remote_delivered_cpd: false, online_cpd: true)
      expect(helper.view_course_phrase(course)).to eq("View dates")
    end
  end

  describe ".clean_course_title" do
    it 'removes " - remote" from the end of the title' do
      title = "Course title - remote"
      expect(helper.clean_course_title(title)).to eq("Course title")
    end

    it 'does not affect title that does not end in  " - remote"' do
      title = "Course title - something else"
      expect(helper.clean_course_title(title))
        .to eq("Course title - something else")
    end
  end

  describe "#certificate_card_summary" do
    it "renders the correct copy for CSA" do
      expect(helper.certificate_card_summary(build(:cs_accelerator))).to eq("This course is part of the KS3 and GCSE Computer Science subject knowledge certificate")
    end

    it "renders the correct copy for Secondary" do
      expect(helper.certificate_card_summary(build(:secondary_certificate))).to eq("This course is part of Teach secondary computing")
    end

    it "renders the correct copy for Primary" do
      expect(helper.certificate_card_summary(build(:primary_certificate))).to eq("This course is part of Teach primary computing")
    end
  end

  describe "#course_duration_text" do
    it "renders the correct duration text" do
      stub_course_templates
      stub_duration_units
      expect(helper.course_duration_text(course_template)).to eq("5 hours")
    end
  end
end
