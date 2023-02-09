require 'rails_helper'

RSpec.describe('courses/_aside-booking', type: :view) do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.all.first }
  let(:programme) { create(:programme) }
  let(:occurrences) { build_list(:achiever_course_occurrence, 3) }
  let(:occurrences_remote) { build_list(:achiever_course_occurrence, 25, remote_delivered_cpd: true) }
  let(:activity) { create(:activity) }
  let(:online_booking_presenter) { OnlineBookingPresenter.new }
  let(:live_booking_presenter) { LiveBookingPresenter.new }
  let!(:face_to_face) { create(:activity, :stem_learning) }
  let(:remote_course) { Achiever::Course::Template.find_by_activity_code('CP428') }

  before do
    stub_course_templates
  end

  describe 'when logged in' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    context 'when its an online course' do
      describe 'when the course is not always on' do
        before do
          assign(:booking, online_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:activity, activity)
          assign(:course, course)

          render
        end

        it 'prompts the user to join the course' do
          expect(rendered).to have_css('.ncce-aside__title', text: 'Join this course')
        end

        it 'does not render the facilitation periods' do
          expect(rendered).not_to have_css('.facilitation-periods')
        end

        it 'tells the user who is delivering the course' do
          expect(rendered).to have_css(
            '.ncce-aside__text',
            text: 'You will be taken to the STEM Learning website to sign up for the online course.'
          )
        end

        it 'renders link to futurelearn LTI' do
          expected_link = "/futurelearn/lti/#{activity.future_learn_course_uuid}" # TODO: link to STEM
          expect(rendered).to have_link('Join this course', href: expected_link)
        end

        it "does not show the 'View course' button" do
          expect(rendered).not_to have_link('View course')
        end
      end

      describe 'when the course is always on' do
        before do
          assign(:booking, online_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:activity, activity)
          assign(:course, course)
          allow_any_instance_of(OnlineBookingPresenter).to receive(:show_facilitation_periods).with(course, occurrences).and_return(true)

          render
        end

        it 'renders the facilitation period list with the expected occurrence count' do
          expect(rendered).to have_css('.facilitation-periods .facilitation-periods__list-item', count: 3)
        end

        it 'formats the occurrence items correctly' do
          expect(rendered).to have_text('15 January—15 February 2099')
        end

        it 'renders the title' do
          expect(rendered).to have_text('View facilitation period(s):')
        end

        it 'renders the details block heading' do
          expect(rendered).to have_css('.ncce-details__summary-text', text: 'What does this mean?')
        end

        it 'renders the details block body' do
          expect(rendered).to have_css('.ncce-details__text', text: /You can join and complete this course at any time/, visible: :hidden)
        end
      end
    end

    context 'when its a face to face course' do
      context 'when a user is not enrolled on a course' do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, course)
          assign(:activity, activity)

          render
        end

        it 'prompts the user to book the course' do
          expect(rendered).to have_css('.ncce-aside__title', text: 'Book this course')
        end

        it 'tells the user who is delivering the course' do
          expect(rendered).to have_css(
            '.ncce-aside__text',
            text: 'You will be taken to the STEM Learning website to see further details.'
          )
        end

        it 'does not render the facilitation periods' do
          expect(rendered).not_to have_css('.facilitation-periods')
        end

        context 'when it renders the list' do
          it 'shows the expected number of occurences' do
            expect(rendered).to have_css('.ncce-booking-list__item', count: 3)
          end

          it 'shows items with the expected content' do
            occurrences.each do |occurrence|
              expect(rendered).to have_css(
                '.ncce-booking-list__date', text: live_booking_presenter.activity_date(occurrence.start_date)
              )

              expect(rendered).to have_css(
                '.ncce-booking-list__address', text: live_booking_presenter.address(occurrence)
              )

              expect(rendered).to have_link(
                'Book',
                href: "https://ncce-www-stage-int.stem.org.uk/cpdredirect/#{occurrence.course_occurrence_no}"
              )
            end
          end

          it "does not show the 'See more dates' button if there are less than 20 items" do
            expect(rendered).not_to have_link('See more dates')
          end

          it "does not show the 'View course' button if there are occurences" do
            expect(rendered).not_to have_link('View course')
          end
        end
      end

      context 'when the user is enrolled on a course' do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Activity.COURSETEMPLATENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Delegate.Is_Fully_Attended": 'True',
              "OnlineCPD": false,
              "Delegate.Progress": '157420003',
              "ActivityVenueAddress.VenueName": 'National STEM Learning Centre',
              "ActivityVenueAddress.VenueCode": '',
              "ActivityVenueAddress.City": 'York',
              "ActivityVenueAddress.PostCode": 'YO10 5DD',
              "ActivityVenueAddress.Address.Line1": 'University of York',
              "Activity.StartDate": "10\/07\/2019 00:00:00",
              "Activity.EndDate": "17\/07\/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:enrolled)
          allow(view).to receive(:course_start_date).and_return('15th January 2099, Thursday 00:00')

          render
        end

        it 'displays the date of the occurance' do
          expect(rendered).to have_text('15th January 2099, Thursday 00:00')
        end

        it 'displays course type' do
          expect(rendered).to have_text('Face to face course')
        end

        it 'displays all parts of the address' do
          expect(rendered).to have_text('National STEM Learning Centre')
          expect(rendered).to have_text('University of York')
          expect(rendered).to have_text('York')
          expect(rendered).to have_text('YO10 5DD')
        end


        it 'display a booking path' do
          expect(rendered).to have_link('Go to course', href: live_booking_presenter.booking_path('cf8903f9-91a2-4d08-ba41-596ea05b498d'))
        end

        it 'displays aside title' do
          expect(rendered).to have_text('You’re booked on this course')
        end

        it 'displays more stem learning and teach computing text' do
          expect(rendered).to have_text('You will be taken to the STEM Learning website to see further details.')
          expect(rendered).to have_text('This course is from Teach Computing and delivered by STEM Learning')
        end
      end

      context 'when a user has completed a course' do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Activity.COURSETEMPLATENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Delegate.Is_Fully_Attended": 'True',
              "OnlineCPD": false,
              "Delegate.Progress": '157420003',
              "ActivityVenueAddress.VenueName": 'National STEM Learning Centre',
              "ActivityVenueAddress.VenueCode": '',
              "ActivityVenueAddress.City": 'York',
              "ActivityVenueAddress.PostCode": 'YO10 5DD',
              "ActivityVenueAddress.Address.Line1": 'University of York',
              "Activity.StartDate": "10\/07\/2019 00:00:00",
              "Activity.EndDate": "17\/07\/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:complete)
          allow(view).to receive(:course_start_date).and_return('15th January 2099, Thursday 00:00')

          render
        end

        it 'displays aside title' do
          expect(rendered).to have_text("You’ve completed this course")
        end

        it 'displays more stem learning and teach computing text' do
          expect(rendered).to have_text('You will be taken to the STEM Learning website to see further details.')
          expect(rendered).to have_text('This course is from Teach Computing and delivered by STEM Learning')
        end

        it 'displays the date of the occurance' do
          expect(rendered).to have_text('15th January 2099, Thursday 00:00')
        end

        it 'displays course type' do
          expect(rendered).to have_text('Face to face course')
        end

        it 'displays all parts of the address' do
          expect(rendered).to have_text('National STEM Learning Centre')
          expect(rendered).to have_text('University of York')
          expect(rendered).to have_text('York')
          expect(rendered).to have_text('YO10 5DD')
        end


        it 'display a booking path' do
          expect(rendered).to have_link('Go to course', href: live_booking_presenter.booking_path('cf8903f9-91a2-4d08-ba41-596ea05b498d'))
        end
      end

    end


    context 'when its a remote course' do

      context 'when a user is not enrolled on a course' do
        before do
          allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

          assign(:course, course)
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences_remote)
          assign(:activity, activity)

          render
        end

        it 'does not render the facilitation periods' do
          expect(rendered).not_to have_css('.facilitation-periods')
        end

        context 'when it renders the list' do
          it 'shows the expected number of occurences' do
            expect(rendered).to have_css('.ncce-booking-list__item', count: 25)
          end

          it 'shows items with the expected content' do
            occurrences_remote.each do |occurrence|
              expect(rendered).to have_css(
                '.ncce-booking-list__date', text: live_booking_presenter.activity_date(occurrence.start_date)
              )

              expect(rendered).to have_css(
                '.ncce-booking-list__address', text: 'Live remote training'
              )

              expect(rendered).to have_link(
                'Book',
                href: "https://ncce-www-stage-int.stem.org.uk/cpdredirect/#{occurrence.course_occurrence_no}"
              )
            end
          end
        end

        context 'when there are no occurances' do
          it "shows the 'Dates coming soon' button" do
            allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

            assign(:course, course)
            assign(:booking, live_booking_presenter)
            assign(:occurrences, [])
            assign(:activity, activity)
            allow_any_instance_of(LiveBookingPresenter).to receive(:show_facilitation_periods).with(course, occurrences).and_return(true)

            render

            expect(rendered).to have_link(
              'Find your local Hub',
              href: "/hubs"
            )
          end
        end
      end

      context 'when a user is enrolled on a course' do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, remote_course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Activity.COURSETEMPLATENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Delegate.Is_Fully_Attended": 'True',
              "OnlineCPD": false,
              "Delegate.Progress": '157420003',
              "ActivityVenueAddress.VenueName": 'National STEM Learning Centre',
              "ActivityVenueAddress.VenueCode": '',
              "ActivityVenueAddress.City": 'York',
              "ActivityVenueAddress.PostCode": 'YO10 5DD',
              "ActivityVenueAddress.Address.Line1": 'University of York',
              "Activity.StartDate": "10\/07\/2019 00:00:00",
              "Activity.EndDate": "17\/07\/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:enrolled)
          allow(view).to receive(:course_start_date).and_return('15th January 2099, Thursday 00:00')

          render
        end

        it 'displays the date of the occurance' do
          expect(rendered).to have_text('15th January 2099, Thursday 00:00')
        end

        it 'displays course type' do
          expect(rendered).to have_text('Live remote training course')
        end

        it 'does not displays the address' do
          expect(rendered).to have_no_text('National STEM Learning Centre, University of York, York, YO10 5DD')
        end


        it 'display a booking path' do
          expect(rendered).to have_link('Go to course', href: live_booking_presenter.booking_path('cf8903f9-91a2-4d08-ba41-596ea05b498d'))
        end
      end

      context 'when a user has completed a course' do
        before do
          assign(:booking, live_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:course, remote_course)
          assign(:activity, activity)
          assign(:user_occurrence,
            Achiever::Course::Delegate.new(JSON.parse({
              "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Activity.COURSETEMPLATENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
              "Delegate.Is_Fully_Attended": 'True',
              "OnlineCPD": false,
              "Delegate.Progress": '157420003',
              "ActivityVenueAddress.VenueName": 'National STEM Learning Centre',
              "ActivityVenueAddress.VenueCode": '',
              "ActivityVenueAddress.City": 'York',
              "ActivityVenueAddress.PostCode": 'YO10 5DD',
              "ActivityVenueAddress.Address.Line1": 'University of York',
              "Activity.StartDate": "10\/07\/2019 00:00:00",
              "Activity.EndDate": "17\/07\/2019 00:00:00"
            }.to_json, object_class: OpenStruct)))
          allow(view).to receive(:user_achievement_state).and_return(:complete)
          allow(view).to receive(:course_start_date).and_return('15th January 2099, Thursday 00:00')

          render
        end

        it 'displays the date of the occurance' do
          expect(rendered).to have_text('15th January 2099, Thursday 00:00')
        end

        it 'displays course type' do
          expect(rendered).to have_text('Live remote training course')
        end

        it 'does not displays the address' do
          expect(rendered).to have_no_text('National STEM Learning Centre, University of York, York, YO10 5DD')
        end


        it 'display a booking path' do
          expect(rendered).to have_link('Go to course', href: live_booking_presenter.booking_path('cf8903f9-91a2-4d08-ba41-596ea05b498d'))
        end
      end
    end



    it "shows the 'Dates coming soon' button if there are no occurrences" do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      assign(:course, course)
      assign(:booking, live_booking_presenter)
      assign(:occurrences, [])
      assign(:activity, activity)

      render

      expect(rendered).to have_link(
        'Find your local Hub',
        href: "/hubs"
      )
    end
  end

  describe 'when not logged in' do
    context 'when its an online course' do
      before do
        assign(:course, course)
        assign(:occurrences, occurrences)
        assign(:booking, online_booking_presenter)
        allow_any_instance_of(OnlineBookingPresenter).to receive(:show_facilitation_periods).with(course, occurrences).and_return(true)

        render
      end

      it 'has the expected title' do
        expect(rendered).to have_css('.ncce-aside__title', text: 'Join this course')
      end

      it 'renders link to log in' do
        expected_link = "/auth/stem?source_uri=#{CGI.escape('http://test.host/courses')}"
        expect(rendered).to have_link('Login to join', href: expected_link)
      end

      it 'renders the facilitation period list with the expected occurrence count' do
        expect(rendered).to have_css('.facilitation-periods .facilitation-periods__list-item', count: 3)
      end

      it 'renders an account creation link' do
        expect(rendered).to have_link('Create an account', href: 'https://ncce-www-stage-int.stem.org.uk/user/register?from=NCCE')
      end
    end

    context 'when its a live course' do

      it "shows the 'Dates coming soon' button if there are no occurrences" do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        assign(:course, course)
        assign(:booking, live_booking_presenter)
        assign(:occurrences, [])
        assign(:activity, activity)
        allow_any_instance_of(LiveBookingPresenter).to receive(:show_facilitation_periods).with(course, occurrences).and_return(true)

        render

        expect(rendered).to have_link(
          'Find your local Hub',
          href: "/hubs"
        )
      end

    end
  end
end
