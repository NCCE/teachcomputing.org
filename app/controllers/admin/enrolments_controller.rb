class Admin::EnrolmentsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	before_action :authenticate_api

  def index
    user = User.find(params[:user_id])
    render json: as_json(user.enrolments)
  end

  private
		def as_json(enrolment)
			enrolment.as_json(methods: :current_state,
													include: [
														{programme: { only: [:title]}},
														{user: { only: [:email]}}
													])
		end
end
