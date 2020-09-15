class Admin::AchievementsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	before_action :authenticate_api

	def create
		user = User.find(params[:user_id])
		activity = Activity.find(params[:activity_id])
		achievement = Achievement.new(activity_id: activity.id, user_id: user.id)

    if achievement.save
      case achievement.programme&.slug
      when 'cs-accelerator'
        AssessmentEligibilityJob.perform_now(user.id, nil)
      when 'primary-certificate'
        PrimaryCertificatePendingTransitionJob.perform_now(user.id, nil)
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

    case achievement.programme&.slug
    when 'cs-accelerator'
      AssessmentEligibilityJob.perform_later(user.id, source: 'AdminAchievementsController.complete')
    when 'primary-certificate'
      PrimaryCertificatePendingTransitionJob.perform_later(user.id, source: 'AdminAchievementsController.complete')
    end

		render json: as_json(achievement), status: 201
  end

 private
		def as_json(achievement)
			achievement.as_json(methods: :current_state,
													include: [
														{activity: { only: [:title, :provider]}},
														{programme: { only: [:title]}},
														{user: { only: [:email]}}
													])
		end
end
