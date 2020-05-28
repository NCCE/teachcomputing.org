class Admin::AchievementsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	before_action :authenticate_api

	def index
		user = User.find(params[:user_id])
		render json: as_json(user.achievements)
	end

	def show
		user = User.find(params[:user_id])
		achievement = user.achievements.find(params[:id])
		render json: as_json(achievement)
	end

	def create
		user = User.find(params[:user_id])
		activity = Activity.find(params[:activity_id])
		achievement = Achievement.new(activity_id: activity.id, user_id: user.id)

    if achievement.save
      if achievement.programme
        case achievement.programme.slug
        when 'cs-accelerator'
          AssessmentEligibilityJob.perform_now(user.id, nil)
        when 'primary-certificate'
          PrimaryCertificatePendingTransitionJob.perform_now(user.id, nil)
        end
      end
			render json: as_json(achievement), status: 201
    else
      render json: {error: achievement.errors.inspect}, status: 409
    end
	end

	def complete
		user = User.find(params[:user_id])
		achievement = user.achievements.find(params[:id])
    achievement.transition_to(:complete)
		render json: as_json(achievement), status: 201
  end

 private
    def authenticate_api
      authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(token, 'secret')
      end
    end

		def as_json(achievement)
			achievement.as_json(methods: :current_state,
													include: [
														{activity: { only: [:title, :provider]}},
														{programme: { only: [:title]}},
														{user: { only: [:email]}}
													])
		end

end
