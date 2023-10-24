class UserController < ApplicationController
  before_action :authenticate_user!

  def teacher_reference_number
    trn = params[:user][:teacher_reference_number]

    if !trn.present?
      flash[:error] = 'Please enter your teacher reference number'
    elsif current_user.update!(teacher_reference_number: trn)
      flash[:notice] = 'Teacher reference number added'
    end
    redirect_to trn_redirect_path || dashboard_path
  end

  private

    def trn_redirect_path
      helpers.safe_redirect_url(params[:redirect_path])
    end
end
