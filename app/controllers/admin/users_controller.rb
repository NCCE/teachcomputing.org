class Admin::UsersController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	before_action :authenticate_api

  def show
    user = User.find_by!(email: params[:email].downcase)
		render json: as_json(user)
  end

  private

  def as_json(user)
    user.as_json(only: [:id, :email, :created_at, :updated_at, :stem_achiever_contact_no], include: [
                  {achievements: { except: [:user_id, :activity_id], include: :activity, methods: :current_state }},
                  {enrolments: { except: [:user_id, :programme_id], include: :programme, methods: :current_state }}
                ])
  end
end
