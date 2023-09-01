module Programmes
  class UserEnroller
    def initialize(params)
      @user_id = params[:user_id]
      @programme_id = params[:programme_id]
      @pathway_slug = params[:pathway_slug]
    end

    def call
      enrolment = UserProgrammeEnrolment.new(user_id: @user_id, programme_id: @programme_id)
      enrolment.assign_pathway(@pathway_slug) if @pathway_slug.present?

      return false unless enrolment.save

      KickOffEmailsJob.perform_later(enrolment.id)
      Achiever::ScheduleCertificateSyncJob.perform_later(enrolment.id)

      QuestionnaireResponse.create(user_id: @user_id, questionnaire: Questionnaire.cs_accelerator) if enrolment.programme.cs_accelerator?
      set_eligible_achievements_for_programme
      true
    end

    private

      def set_eligible_achievements_for_programme
        user_achievements = Achievement.where(user_id: @user_id, programme_id: nil)
        user_achievements.each do |achievement|
          programme_activity = ProgrammeActivity.find_by(activity_id: achievement.activity_id, programme_id: @programme_id)
          achievement.update(programme_id: @programme_id) if programme_activity
        end
      end
  end
end
