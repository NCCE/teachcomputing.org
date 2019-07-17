class UserController < ApplicationController
  before_action :authenticate_user!

  def teacher_reference_number
    trn = params[:user][:teacher_reference_number]
    redirect_path = params[:redirect_path] || dashboard_path

    if !trn.present?
      flash[:error] = "Please enter your teacher reference number"
    elsif current_user.update_attributes!(teacher_reference_number: trn)
      flash[:notice] = "Teacher reference number added"
    end
    return redirect_to redirect_path
  end
end
