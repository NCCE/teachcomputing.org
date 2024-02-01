module Api
  class AchievementsController < ApiController
    def create
      user = User.find(params[:user_id])
      activity = Activity.find(params[:activity_id])
      achievement = Achievement.new(activity_id: activity.id, user_id: user.id)

      if achievement.save
        AssessmentEligibilityJob.perform_now(user.id)
        CertificatePendingTransitionJob.perform_now(user, {source: "AdminAchievementsController.create"})

        render json: as_json(achievement), status: 201
      else
        render json: {error: achievement.errors.inspect}, status: 409
      end
    end

    def complete
      user = User.find(params[:user_id])
      achievement = user.achievements.find(params[:achievement_id])
      achievement.transition_to(:complete)

      AssessmentEligibilityJob.perform_later(user.id)
      CertificatePendingTransitionJob.perform_now(user, {source: "AdminAchievementsController.complete"})

      render json: as_json(achievement), status: 201
    end

    private

    def as_json(achievement)
      achievement.as_json(methods: :current_state,
        include: [
          {activity: {only: %i[title provider]}},
          {user: {only: [:email]}}
        ])
    end
  end
end
