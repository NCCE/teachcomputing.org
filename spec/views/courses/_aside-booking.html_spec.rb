require "rails_helper"

RSpec.describe("courses/_aside-booking", type: :view) do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.all.first }
  let(:programme) { create(:programme) }
  let(:occurrences) { build_list(:achiever_course_occurrence, 3) }
  let(:occurrences_remote) { build_list(:achiever_course_occurrence, 25, remote_delivered_cpd: true) }
  let(:activity) { create(:activity) }
  let(:online_booking_presenter) { OnlineBookingPresenter.new }
  let(:live_booking_presenter) { LiveBookingPresenter.new }
  let!(:face_to_face) { create(:activity, :stem_learning) }
  let(:remote_course) { Achiever::Course::Template.find_by_activity_code("CP428") }
  let(:online_course_always_on) {
    c = Achiever::Course::Template.find_by_activity_code("CO225")
    c.always_on = true
    c
  }
  let(:online_course_not_always_on) { Achiever::Course::Template.find_by_activity_code("CO225") }

  before do
    stub_course_templates
  end

  describe "when logged in" do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    context "when its an online course" do
      describe "when the course is not always on" do
        # Not always on is now used to allow online courses to show occurences, this is a trial to see how it goes.
        # If this works, it will become the norm, at which point we will tidy up the logic
        before do
          assign(:booking, online_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:activity, activity)
          assign(:course, online_course_not_always_on)
          assign(:start_date, Date.tomorrow)

          render
        end

        it "prompts the user to join the course" do
          expect(rendered).to have_css(".ncce-aside__title", text: "Join this course")
        end

        it "tells the user who is delivering the course" do
          expect(rendered).to have_css(
            ".ncce-aside__text",
            text: "You will be taken to the STEM Learning website to enrol onto the online course."
          )
        end

        it "renders link to STEM Learning booking page" do
          expected_link = "https://cpd.stem.org.uk/app/#{activity.stem_activity_code}"
          expect(rendered).to have_link("Join", href: expected_link)
        end

        it "does not show the 'View course' button" do
          expect(rendered).not_to have_link("View course")
        end
      end

      describe "when the course is always on" do
        before do
          assign(:booking, online_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:activity, activity)
          assign(:course, online_course_always_on)
        end

        context "when the course starts tomorrow" do
          before do
            assign(:start_date, Date.tomorrow)
            assign(:started, false)
            render
          end

          it "prompts the user to join the course" do
            expect(rendered).to have_css(".ncce-aside__title", text: "Join this course")
          end

          it "tells the user who is delivering the course" do
            expect(rendered)
              .to have_css(
                ".ncce-aside__text",
                text: "You will be taken to the STEM Learning website to enrol onto the online course."
              )
          end

          it "does not show the 'View course' button" do
            expect(rendered).not_to have_link("View course")
          end

          it "renders link to STEM Learning booking page" do
            expected_link = "https://cpd.stem.org.uk/app/#{activity.stem_activity_code}"
            expect(rendered).to have_link("Join this course", href: expected_link)
          end

          it "shows the start date" do
            expect(rendered).to have_css(".ncce-aside", text: "Available from #{Date.tomorrow.strftime("%d %B %Y")}")
          end
        end

        context "when the course started today" do
          before do
            assign(:start_date, Time.zone.today)
            assign(:started, true)

            render
          end

          it "renders link to STEM Learning booking page" do
            expected_link = "https://cpd.stem.org.uk/app/#{activity.stem_activity_code}"
            expect(rendered).to have_link("Join this course", href: expected_link)
          end

          it "does not show the start date" do
            expect(rendered).not_to have_text "Available from"
            expect(rendered).not_to have_text (Date.tomorrow.year % 100).to_s
          end
        end

        context "when the user is enrolled on a course" do
          before do
            assign(:booking, online_booking_presenter)
            assign(:occurrences, occurrences)
            assign(:course, online_course_always_on)
            assign(:activity, activity)
            assign(
              :user_occurrence,
              Achiever::Course::Delegate.new(
                JSON.parse(
                  {
                    "Activity.COURSEOCCURRENCENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
                    "Activity.COURSETEMPLATENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
                    "Delegate.Is_Fully_Attended": "True",
                    OnlineCPD: true,
                    "Delegate.Progress": "157420003"
                  }.to_json, object_class: OpenStruct
                )
              )
            )
            allow(view).to receive(:user_achievement_state).and_return(:enrolled)
          end

          context "when the course is in the future" do
            before do
              assign(:start_date, Date.new(2023, 4, 1))
              assign(:started, false)
            end

            it "tells the user they are enrolled" do
              render
              expect(rendered).to have_text "You are enrolled on this course"
            end

            it "reminds the user about the email" do
              render
              expect(rendered).to have_text "Check your email"
            end

            it "shows the start date" do
              render
              expect(rendered).to have_text "Available from 01 April 2023"
            end
          end

          context "when the course has started" do
            before do
              assign(:start_date, Date.new(2023, 4, 1))
              assign(:started, true)
            end

            it "tells the user they are enrolled" do
              render
              expect(rendered).to have_text "You are enrolled on this course"
            end

            it "does not mention email" do
              render
              expect(rendered).not_to have_text "Check your email"
            end

            it "does not show the start date" do
              render
              expect(rendered).not_to have_text "Available from"
              expect(rendered).not_to have_text "April"
            end

            it "links to MyLearning" do
              render
              expect(rendered).to have_link("Continue on MyLearning", href: "https://moodle.example.com/my/")
            end
          end
        end

        context "when the user has completed the course" do
          before do
            assign(:booking, online_booking_presenter)
            assign(:occurrences, occurrences)
            assign(:course, online_course_always_on)
            assign(:activity, activity)
            assign(
              :user_occurrence,
              Achiever::Course::Delegate.new(
                JSON.parse(
                  {
                    "Activity.COURSEOCCURRENCENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
                    "Activity.COURSETEMPLATENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
                    "Delegate.Is_Fully_Attended": "True",
                    OnlineCPD: true,
                    "Delegate.Progress": "157420003"
                  }.to_json, object_class: OpenStruct
                )
              )
            )
            allow(view).to receive(:user_achievement_state).and_return(:complete)
          end

          it "tells the user they have completed it" do
            render
            expect(rendered).to have_text "You've completed this course"
          end

          it "does not mention email" do
            render
            expect(rendered).not_to have_text "Check your email"
          end

          it "does not show the start date" do
            render
            expect(rendered).not_to have_text "Available from"
            expect(rendered).not_to have_text "April"
          end

          it "links to MyLearning" do
            render
            expect(rendered).to have_link("Visit MyLearning", href: "https://moodle.example.com/my/")
          end
        end
      end
    end

    context "when its a face to face course" do
      context "when a user is not enrolled on a course" do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, course)
          assign(:activity, activity)

          render
        end

        it "prompts the user to book the course" do
          expect(rendered).to have_css(".ncce-aside__title", text: "Book this course")
        end

        it "tells the user who is delivering the course" do
          expect(rendered).to have_css(
            ".ncce-aside__text",
            text: "You will be taken to the STEM Learning website to see further details."
          )
        end

        it "does not render the facilitation periods" do
          expect(rendered).not_to have_css(".facilitation-periods")
        end

        context "when it renders the list" do
          it "shows the expected number of occurences" do
            expect(rendered).to have_css(".ncce-booking-list__item", count: 3)
          end

          it "shows items with the expected content" do
            occurrences.each do |occurrence|
              expect(rendered).to have_css(
                ".ncce-booking-list__date", text: live_booking_presenter.activity_date(occurrence.start_date, occurrence.end_date)
              )

              expect(rendered).to have_css(
                ".ncce-booking-list__address", text: live_booking_presenter.address(occurrence)
              )

              expect(rendered).to have_link(
                "Book",
                href: "https://cpd.stem.org.uk/app/#{activity.stem_activity_code}"
              )
            end
          end

          it "does not show the 'See more dates' button if there are less than 20 items" do
            expect(rendered).not_to have_link("See more dates")
          end

          it "does not show the 'View course' button if there are occurences" do
            expect(rendered).not_to have_link("View course")
          end
        end
      end

      context "when the user is enrolled on a course" do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Activity.COURSETEMPLATENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Delegate.Is_Fully_Attended": "True",
              OnlineCPD: false,
              "Delegate.Progress": "157420003",
              "ActivityVenueAddress.VenueName": "National STEM Learning Centre",
              "ActivityVenueAddress.VenueCode": "",
              "ActivityVenueAddress.City": "York",
              "ActivityVenueAddress.PostCode": "YO10 5DD",
              "ActivityVenueAddress.Address.Line1": "University of York",
              "Activity.StartDate": "10/07/2019 00:00:00",
              "Activity.EndDate": "17/07/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:enrolled)
          allow(view).to receive(:course_start_date).and_return("15th January 2099, Thursday 00:00")

          render
        end

        it "displays the date of the occurance" do
          expect(rendered).to have_text("15th January 2099, Thursday 00:00")
        end

        it "displays course type" do
          expect(rendered).to have_text("Face to face course")
        end

        it "displays all parts of the address" do
          expect(rendered).to have_text("National STEM Learning Centre")
          expect(rendered).to have_text("University of York")
          expect(rendered).to have_text("York")
          expect(rendered).to have_text("YO10 5DD")
        end

        it "display a booking path" do
          expect(rendered).to have_link("Go to course", href: live_booking_presenter.booking_path("cf8903f9-91a2-4d08-ba41-596ea05b498d"))
        end

        it "displays aside title" do
          expect(rendered).to have_text("You’re booked on this course")
        end

        it "displays more stem learning text" do
          expect(rendered).to have_text("You will be taken to the STEM Learning website to see further details.")
        end
      end

      context "when a user has completed a course" do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Activity.COURSETEMPLATENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Delegate.Is_Fully_Attended": "True",
              OnlineCPD: false,
              "Delegate.Progress": "157420003",
              "ActivityVenueAddress.VenueName": "National STEM Learning Centre",
              "ActivityVenueAddress.VenueCode": "",
              "ActivityVenueAddress.City": "York",
              "ActivityVenueAddress.PostCode": "YO10 5DD",
              "ActivityVenueAddress.Address.Line1": "University of York",
              "Activity.StartDate": "10/07/2019 00:00:00",
              "Activity.EndDate": "17/07/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:complete)
          allow(view).to receive(:course_start_date).and_return("15th January 2099, Thursday 00:00")

          render
        end

        it "displays aside title" do
          expect(rendered).to have_text("You’ve completed this course")
        end

        it "displays more stem learning text" do
          expect(rendered).to have_text("You will be taken to the STEM Learning website to see further details.")
        end

        it "displays the date of the occurance" do
          expect(rendered).to have_text("15th January 2099, Thursday 00:00")
        end

        it "displays course type" do
          expect(rendered).to have_text("Face to face course")
        end

        it "displays all parts of the address" do
          expect(rendered).to have_text("National STEM Learning Centre")
          expect(rendered).to have_text("University of York")
          expect(rendered).to have_text("York")
          expect(rendered).to have_text("YO10 5DD")
        end

        it "display a booking path" do
          expect(rendered).to have_link("Go to course", href: live_booking_presenter.booking_path("cf8903f9-91a2-4d08-ba41-596ea05b498d"))
        end

        it "lists the providers" do
          expect(rendered).to have_text("This course is from the National Centre for Computing Education and is delivered by STEM Learning.")
        end
      end
    end

    context "when its a remote course" do
      context "when a user is not enrolled on a course" do
        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

          assign(:course, course)
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences_remote)
          assign(:activity, activity)

          render
        end

        it "does not render the facilitation periods" do
          expect(rendered).not_to have_css(".facilitation-periods")
        end

        context "when it renders the list" do
          it "shows the expected number of occurences" do
            expect(rendered).to have_css(".ncce-booking-list__item", count: 25)
          end

          it "shows items with the expected content" do
            occurrences_remote.each do |occurrence|
              expect(rendered).to have_css(
                ".ncce-booking-list__date", text: live_booking_presenter.activity_date(occurrence.start_date, occurrence.end_date)
              )

              expect(rendered).to have_css(
                ".ncce-booking-list__address", text: "Live remote training"
              )

              expect(rendered).to have_link(
                "Book",
                href: "https://cpd.stem.org.uk/app/#{activity.stem_activity_code}"
              )
            end
          end
        end
      end

      context "when a user is enrolled on a course" do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, remote_course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Activity.COURSETEMPLATENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Delegate.Is_Fully_Attended": "True",
              OnlineCPD: false,
              "Delegate.Progress": "157420003",
              "ActivityVenueAddress.VenueName": "National STEM Learning Centre",
              "ActivityVenueAddress.VenueCode": "",
              "ActivityVenueAddress.City": "York",
              "ActivityVenueAddress.PostCode": "YO10 5DD",
              "ActivityVenueAddress.Address.Line1": "University of York",
              "Activity.StartDate": "10/07/2019 00:00:00",
              "Activity.EndDate": "17/07/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:enrolled)
          allow(view).to receive(:course_start_date).and_return("15th January 2099, Thursday 00:00")

          render
        end

        it "displays the date of the occurance" do
          expect(rendered).to have_text("15th January 2099, Thursday 00:00")
        end

        it "displays course type" do
          expect(rendered).to have_text("Live remote training course")
        end

        it "does not displays the address" do
          expect(rendered).to have_no_text("National STEM Learning Centre, University of York, York, YO10 5DD")
        end

        it "display a booking path" do
          expect(rendered).to have_link("Go to course", href: live_booking_presenter.booking_path("cf8903f9-91a2-4d08-ba41-596ea05b498d"))
        end
      end

      context "when a user has completed a course" do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, remote_course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Activity.COURSETEMPLATENO": "cf8903f9-91a2-4d08-ba41-596ea05b498d",
              "Delegate.Is_Fully_Attended": "True",
              OnlineCPD: false,
              "Delegate.Progress": "157420003",
              "ActivityVenueAddress.VenueName": "National STEM Learning Centre",
              "ActivityVenueAddress.VenueCode": "",
              "ActivityVenueAddress.City": "York",
              "ActivityVenueAddress.PostCode": "YO10 5DD",
              "ActivityVenueAddress.Address.Line1": "University of York",
              "Activity.StartDate": "10/07/2019 00:00:00",
              "Activity.EndDate": "17/07/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:complete)
          allow(view).to receive(:course_start_date).and_return("15th January 2099, Thursday 00:00")

          render
        end

        it "displays the date of the occurance" do
          expect(rendered).to have_text("15th January 2099, Thursday 00:00")
        end

        it "displays course type" do
          expect(rendered).to have_text("Live remote training course")
        end

        it "does not displays the address" do
          expect(rendered).to have_no_text("National STEM Learning Centre, University of York, York, YO10 5DD")
        end

        it "display a booking path" do
          expect(rendered).to have_link("Go to course", href: live_booking_presenter.booking_path("cf8903f9-91a2-4d08-ba41-596ea05b498d"))
        end
      end
    end
  end

  describe "when not logged in" do
    context "when its an online course that has not started" do
      before do
        assign(:course, online_course_always_on)
        assign(:occurrences, occurrences)
        assign(:booking, online_booking_presenter)
        assign(:started, false)
        assign(:start_date, Date.new(2023, 4, 1))

        render
      end

      it "has the expected title" do
        expect(rendered).to have_css(".ncce-aside__title", text: "Join this course")
      end

      it "says that need to be logged in" do
        expect(rendered).to have_text "You need to be logged in to join the course."
      end

      it "renders link to log in" do
        expected_link = "/auth/stem?source_uri=#{CGI.escape("http://test.host/courses")}"
        expect(rendered).to have_link("Login to join", href: expected_link)
      end

      it "renders the start date" do
        expect(rendered).to have_text("Available from 01 April 2023")
      end

      it "renders an account creation link" do
        expect(rendered).to have_link("Create STEM Learning account", href: /auth\/stem\?screen_hint=signup/)
      end
    end

    context "when its an online course that has started" do
      before do
        assign(:course, course)
        assign(:occurrences, occurrences)
        assign(:booking, online_booking_presenter)
        assign(:started, true)
        assign(:start_date, Date.new(2023, 4, 1))

        render
      end

      it "does not render the start date" do
        expect(rendered).not_to have_text "April"
      end
    end

    context "when its a remote course" do
      before do
        assign(:course, remote_course)
        assign(:booking, live_booking_presenter)
        assign(:activity, activity)
      end

      it "and when there is at least one occurrence, says that need to be logged in, " do
        assign(:occurrences, [build(:achiever_course_occurrence)])
        render

        expect(rendered).to have_text "You need to be logged in to start the course."
      end
    end
  end
end
