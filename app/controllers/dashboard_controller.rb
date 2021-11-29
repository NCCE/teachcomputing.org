class DashboardController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!

  def show
    @incomplete_achievements = current_user.achievements.not_in_state(:dropped, :complete)
                                           .with_courses.order('created_at DESC')
    @completed_achievements = current_user.achievements.in_state(:complete)
                                          .with_courses.order('updated_at DESC')

    # Remove when going live, for testing:
    user_courses = [
      Achiever::Course::Delegate.new(JSON.parse({
        "Activity.COURSEOCCURRENCENO": 'cf8903f9-91a2-4d08-ba41-596ea05b498d',
        "Activity.COURSETEMPLATENO": '7159562d-4b1a-44f3-b4d7-3e677b9898f2',
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
    ]
    # user_courses = Achiever::Course::Delegate.find_by_achiever_contact_number(current_user.stem_achiever_contact_no)
    @user_courses = user_courses.select { |course| %w[enrolled attended].include?(course.attendance_status) }

    render :show
  end
end
