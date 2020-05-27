class Admin::AchievementsController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	before_action :authenticate_api


	def index
		u = User.find(params[:user_id])
		render json: u.achievements.to_json(except: [:created_at, :updated_at], include: [activity: { only: [:title]} ])
	end

	def show
		# u = User.find(params[:user_id])
		a = Achievement.find(params[:id])
		render json: a
	end

	def create
		u = User.find(params[:user_id])
		a = Activity.find(params[:activity_id])
		@achievement = Achievement.new(activity_id: a.id, user_id: u.id)

    if @achievement.save
      if @achievement.programme
        case @achievement.programme.slug
        when 'cs-accelerator'
          AssessmentEligibilityJob.perform_now(u.id)
        when 'primary-certificate'
          PrimaryCertificatePendingTransitionJob.perform_now(u.id)
        end
      end
			# redirect_to admin_user_achievement_path(user: u, achievement: @achievement)
			render json: @achievement, status: 201
    else
			#head 400
      render json: {error: @achievement.errors.inspect}, status: 409
    end
	end

	def complete
		u = User.find(params[:user_id])
		@achievement = Achievement.find(params[:id])
    @achievement.transition_to(:complete)
		render json: @achievement, status: 201
  end

 private
    def authenticate_api
      authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(token, 'secret')
      end
    end

end
