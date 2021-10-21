require 'rails_helper'

RSpec.describe('courses/_aside-booking', type: :view) do
  let(:user) { create(:user) }
  let(:course) { Achiever::Course::Template.all.first }
  let(:programme) { create(:programme) }
  let(:occurrences) { build_list(:achiever_course_occurrence, 3) }
  let(:occurrences_remote) { build_list(:achiever_course_occurrence, 25, remote_delivered_cpd: true) }
  let(:activity) { create(:activity) }
  let(:online_booking_presenter) { OnlineBookingPresenter.new }
  let(:stem_booking_presenter) { StemBookingPresenter.new }

  before do
    stub_course_templates
  end

  describe 'when logged in' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it 'does not render when the user is enrolled' do
      allow(view).to receive(:user_achievement_state).and_return(:complete)
      render

      expect(rendered).not_to have_css('.ncce-aside')
    end

    context 'when its an online course' do
      describe 'when the course is not always on' do
        before do
          assign(:booking, online_booking_presenter)
          assign(:occurrences, occurrences)
          assign(:activity, activity)

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
            text: 'You will be taken to the FutureLearn website to create an account and sign up for online courses.'
          )
        end

        it 'renders link to futurelearn LTI' do
          expected_link = "/futurelearn/lti/#{activity.future_learn_course_uuid}"
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
      before do
        assign(:booking, stem_booking_presenter)
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
          text: 'You will be taken to the STEM Learning website to see further details and book.'
        )
      end

      context 'when it renders the list' do
        it 'shows the expected number of occurences' do
          expect(rendered).to have_css('.ncce-booking-list__item', count: 3)
        end

        it 'shows items with the expected content' do
          occurrences.each do |occurrence|
            expect(rendered).to have_css(
              '.ncce-booking-list__date', text: stem_booking_presenter.activity_date(occurrence.start_date)
            )

            expect(rendered).to have_css(
              '.ncce-booking-list__address', text: stem_booking_presenter.address(occurrence)
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

    context 'when its a remote course' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

        assign(:course, course)
        assign(:booking, stem_booking_presenter)
        assign(:occurrences, occurrences_remote)
        assign(:activity, activity)

        render
      end

      context 'when it renders the list' do
        it 'shows the expected number of occurences' do
          expect(rendered).to have_css('.ncce-booking-list__item', count: 25)
        end

        it 'shows items with the expected content' do
          occurrences_remote.each do |occurrence|
            expect(rendered).to have_css(
              '.ncce-booking-list__date', text: stem_booking_presenter.activity_date(occurrence.start_date)
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

      it "shows the 'See more dates' button if there are more than 20 items" do
        expect(rendered).to have_link(
          'See more dates',
          href: "https://ncce-www-stage-int.stem.org.uk/cpdredirect/#{course.course_template_no}"
        )
      end
    end

    it "shows the 'View Course' button if there are no occurrences" do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)

      assign(:course, course)
      assign(:booking, stem_booking_presenter)
      assign(:occurrences, [])
      assign(:activity, activity)

      render

      expect(rendered).to have_link(
        'View course',
        href: "https://ncce-www-stage-int.stem.org.uk/cpdredirect/#{course.course_template_no}"
      )
    end
  end

  describe 'when not logged in' do
    context 'when its an online course' do
      before do
        assign(:course, course)
        assign(:booking, online_booking_presenter)

        render
      end

      it 'renders link to log in' do
        expected_link = "/auth/stem?source_uri=#{CGI.escape('http://test.host/courses')}"
        expect(rendered).to have_link('Login to join this course', href: expected_link)
      end

      it 'renders an account creation link' do
        expect(rendered).to have_link('Create an account', href: 'https://ncce-www-stage-int.stem.org.uk/user/register?from=NCCE')
      end
    end

    context 'when its a stem course' do
      before do
        assign(:course, course)
        assign(:booking, stem_booking_presenter)

        render
      end

      it 'renders link to log in' do
        expected_link = "/auth/stem?source_uri=#{CGI.escape('http://test.host/courses')}"
        expect(rendered).to have_link('Login to book this course', href: expected_link)
      end
    end
  end
end
