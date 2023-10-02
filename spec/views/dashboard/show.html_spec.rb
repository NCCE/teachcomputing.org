require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let!(:online_activity) { create(:activity, :my_learning) }
  let!(:remote_activity) { create(:activity, :remote) }
  let!(:face_to_face) { create(:activity, :stem_learning) }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:cs_accelerator) { create(:cs_accelerator) }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let!(:i_belong) { create(:i_belong) }
  let!(:a_level) { create(:a_level) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: cs_accelerator.id)
  end

  before do
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    @incomplete_achievements = []
    @completed_achievements = []
  end

  context 'when the user has not enrolled' do
    before do
      render
    end

    it 'has a title' do
      expect(rendered).to have_css('h1', text: 'Your dashboard')
    end

    it 'has courses section' do
      expect(rendered).to have_css('h2', text: 'Your courses')
    end

    it 'shows the courses link' do
      expect(rendered).to have_link('Browse our courses', href: '/courses')
    end
  end

  context 'when the user has enrolled on a programme' do
    before do
      user_programme_enrolment
      user.reload
      render
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Certificates')
    end
  end

  context 'when there are no achievements' do
    before do
      render
    end

    it 'has no activity list' do
      expect(rendered).not_to have_css('.ncce-activity-list')
    end
  end

  context 'when there are only incomplete achievements' do
    before do
      @incomplete_achievements = [create(:achievement, user: user)]
      render
    end

    it 'renders a checkbox with no ticks' do
      expect(rendered).to have_css('.ncce-activity-list__item-text--incomplete')
    end

    it 'shows the enrolled prefix' do
      expect(rendered).to have_text('Enrolled')
    end

    it 'does not render an empty list for complete achievements' do
      expect(rendered).to have_css('.ncce-activity-list', count: 1)
    end

    it 'shows the expected course type' do
      expect(rendered).to have_css('.icon-map-pin', text: 'Face to face course')
    end
  end

  context 'when there are only complete achievements' do
    before do
      @completed_achievements = [create(:completed_achievement, user: user)]
      render
    end

    it 'renders a checkbox with ticks' do
      expect(rendered).to have_css('.ncce-activity-list__item-text')
    end

    it 'shows the completed prefix' do
      expect(rendered).to have_text('Completed')
    end

    it 'does not render an empty list for incomplete achievements' do
      expect(rendered).to have_css('.ncce-activity-list', count: 1)
    end
  end

  context 'when there are both complete and incomplete achievements' do
    before do
      assign(:incomplete_achievements, create_list(:achievement, 2, user: user))
      assign(:completed_achievements, create_list(:completed_achievement, 2, user: user))
      assign(:user_course_info, [])

      render
    end

    it 'has an activity list with the expected number of items' do
      expect(rendered).to have_css('.ncce-activity-list li', count: 4)
    end
  end

  context "when there's an achievement not part of a programme" do
    before do
      assign(:incomplete_achievements, [create(:achievement, user: user)])
      render
    end

    it 'has an activity list with the expected number of items' do
      expect(rendered).to have_css('.ncce-activity-list li', count: 1)
    end
  end

  context "when there's a face to face achievement" do
    before do
      assign(:incomplete_achievements, [create(:achievement, activity: face_to_face)])
      assign(:user_course_info, [
               Achiever::Course::Delegate.new(JSON.parse({
                 "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
                 "Activity.COURSETEMPLATENO": face_to_face.stem_course_template_no,
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
               }.to_json, object_class: OpenStruct)),
               Achiever::Course::Delegate.new(JSON.parse({
                 "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
                 "Activity.COURSETEMPLATENO": '92f4f86e-0237-4ecc-a905-2f6c62d6b5ae',
                 "Delegate.Is_Fully_Attended": 'False',
                 "OnlineCPD": false,
                 "Delegate.Progress": '157420003',
                 "ActivityVenueAddress.VenueName": 'Raspberry Pi Foundation',
                 "ActivityVenueAddress.VenueCode": '',
                 "ActivityVenueAddress.City": 'Cambridge',
                 "ActivityVenueAddress.PostCode": 'CB2 1NT',
                 "ActivityVenueAddress.Address.Line1": '37 Hills Road',
                 "Activity.StartDate": "10\/07\/2019 00:00:00",
                 "Activity.EndDate": "17\/07\/2019 00:00:00"
               }.to_json, object_class: OpenStruct))
             ])

      render
    end

    it 'shows the address' do
      expect(rendered).to have_css(
        '.ncce-activity-list__subtext--address',
        text: 'National STEM Learning Centre, University of York, York, YO10 5DD'
      )
    end

    it 'shows the providers component' do
      expect(rendered).to have_css('.provider-logos-component')
    end
  end

  context "when there's an online achievement" do
    before do
      assign(:incomplete_achievements, [create(:achievement, activity: online_activity)])
      render
    end

    it 'shows the expected course type' do
      expect(rendered).to have_css('.icon-online', text: 'Online course')
    end

    it 'does not show an address' do
      expect(rendered).not_to have_css('.ncce-activity-list__subtext--address')
    end

    it 'shows the providers component' do
      expect(rendered).to have_css('.provider-logos-component')
    end
  end

  context "when there's a remote achievement" do
    before do
      assign(:incomplete_achievements, [create(:achievement, activity: remote_activity)])
      render
    end

    it 'shows the expected course type' do
      expect(rendered).to have_css('.icon-remote', text: 'Live remote course')
    end

    it 'does not show an address' do
      expect(rendered).not_to have_css('.ncce-activity-list__subtext--address')
    end

    it 'shows the providers component' do
      expect(rendered).to have_css('.provider-logos-component')
    end
  end
end
