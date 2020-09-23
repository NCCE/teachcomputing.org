class Admin::UserProgrammeEnrolmentsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	before_action :authenticate_api

  def show
    enrolment = UserProgrammeEnrolment.find(params[:id])
		render json: as_json(enrolment)
  end

  def complete
    enrolment = UserProgrammeEnrolment.find(params[:user_programme_enrolment_id])
    if enrolment.transition_to(:complete)
      render json: as_json(enrolment), status: 201
    else
      render json: as_json(enrolment), status: 409
    end
  end

  def enrolled
    enrolment = UserProgrammeEnrolment.find(params[:user_programme_enrolment_id])
    if enrolment.transition_to(:enrolled)
      render json: as_json(enrolment), status: 201
    else
      render json: as_json(enrolment), status: 409
    end
  end

  def flag
    enrolment = UserProgrammeEnrolment.find(params[:user_programme_enrolment_id])
    enrolment.update(flagged: true)
		render json: as_json(enrolment), status: 201
  end

  private

  def as_json(enrolment)
    enrolment.as_json(methods: :current_state, include: [{ user: { only: [:email, :stem_achiever_contact_no]}}, { programme: { only: [:title]}, user_programme_enrolment_transitions: {}}])
  end
end
