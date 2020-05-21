# require "#{Rails.root}/jobs/assessment_eligibility_job.rb"
# require "#{Rails.root}/jobs/primary_certificate_pending_transition_job.rb"
class Admin::AchievementsController < ApplicationController	
	protect_from_forgery unless: -> { request.format.json? }
	
	def index
		u = User.find(params[:user_id])
		render json: u.achievements, status: 200
	end

	def show
		# u = User.find(params[:user_id])
		a = Achievement.find(params[:id])
		render json: a, status: 200
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

end