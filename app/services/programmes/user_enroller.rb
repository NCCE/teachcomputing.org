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

      user = User.find(@user_id)
      programme = Programme.find(@programme_id)

      applicable_achievements = user
        .achievements
        .in_state(:complete)
        .with_category(Activity::FACE_TO_FACE_CATEGORY)
        .belonging_to_programme(programme)

      # we only need to call the job with the first achievement as you can only
      # have one badge per programme.
      IssueBadgeJob.perform_later(applicable_achievements.first) if applicable_achievements.size >= 1

      QuestionnaireResponse.create(user_id: @user_id, questionnaire: Questionnaire.cs_accelerator) if enrolment.programme.cs_accelerator?
      true
    end
  end
end
