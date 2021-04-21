module Api
  class AchievementsController < ApiController
    def create
      user = User.find(params[:user_id])
      activity = Activity.find(params[:activity_id])
      achievement = Achievement.new(activity_id: activity.id, user_id: user.id)

      if achievement.save
        case achievement.programme&.slug
        when 'cs-accelerator'
          AssessmentEligibilityJob.perform_now(user.id, nil)
        when 'primary-certificate'
          CertificatePendingTransitionJob.set(wait: 1.minute).perform_later(achievement.programme, user.id, nil)
        end
        render json: as_json(achievement), status: 201
      else
        render json: { error: achievement.errors.inspect }, status: 409
      end
    end

    def complete
      user = User.find(params[:user_id])
      achievement = user.achievements.find(params[:achievement_id])
      achievement.transition_to(:complete)

      case achievement.programme&.slug
      when 'cs-accelerator'
        AssessmentEligibilityJob.perform_later(user.id, source: 'AdminAchievementsController.complete')
      when 'primary-certificate' || 'secondary-certificate'
        CertificatePendingTransitionJob.set(wait: 1.minute).perform_later(achievement.programme, user.id,
                                                      source: 'AdminAchievementsController.complete')
      end

      render json: as_json(achievement), status: 201
    end

    private

      def as_json(achievement)
        achievement.as_json(methods: :current_state,
                            include: [
                              { activity: { only: %i[title provider] } },
                              { programme: { only: [:title] } },
                              { user: { only: [:email] } }
                            ])
      end
  end
end
