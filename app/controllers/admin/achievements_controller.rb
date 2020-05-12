class Admin::AchievementsController < ApplicationController	
	protect_from_forgery unless: -> { request.format.json? }

	def index
		u = User.find(params[:user_id])
		render json: u.achievements
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
          AssesmentEligibilityJob.perform_now(current_user.id, source: 'AchievementsController.create')
        when 'primary-certificate'
          PrimaryCertificatePendingTransitionJob.perform_now(current_user.id, source: 'AchievementsController.create')
        end
      end
    else
			head 400
      render json: {error: @achievement.errors.inspect}
    end
		# redirect_to admin_user_achievement_path(user: u, achievement: @achievement)
		render json: @achievement
	end

end