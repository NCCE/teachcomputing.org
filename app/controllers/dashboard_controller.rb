class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @achievements = current_user.achievements
    @contact_booking_list = ContactBookingList.fromAchiever(current_user.stem_achiever_contact_no)

    render :show
  end
end
