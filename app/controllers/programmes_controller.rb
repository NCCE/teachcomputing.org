class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :find_programme, only: %i[show complete certificate]
  before_action :user_enrolled?, only: %i[show complete certificate]

  def show
    return redirect_to programme_complete_path(@programme.slug) if @programme.user_completed?(current_user)

    @achievement_presenters = ProgrammeAchievementPresenters.new
    @achievement_presenters.create(@programme, current_user)
    assessment_state_details
    render "programmes/#{@programme.slug}/show"
  end

  def complete
    return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

    @achievement_presenters = ProgrammeAchievementPresenters.new.create(@programme, current_user)

    assessment_state_details if @programme.assessment
    render "programmes/#{@programme.slug}/complete"
  end

  def certificate
    return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

    get_certificate_details
    render "programmes/#{@programme.slug}/certificate", layout: 'certificate'
  end

  private

    def find_programme
      @programme = Programme.enrollable.find_by!(slug: params[:slug])
    end

    # def achievements_by_category
    #   achievements = current_user.achievements.for_programme(@programme).sort_complete_first
    #   @online_achievements = achievements.with_category('online').take(2)
    #   @face_to_face_achievements = achievements.with_category('face-to-face').take(2)
    #   @downloaded_diagnostic = achievements.with_category('action').where(activities: { slug: 'diagnostic-tool' }).any?
    # end

    def assessment_state_details
      @enough_credits_for_test = helpers.can_take_accelerator_test?(current_user, @programme)
      @num_attempts = 0
      return if !@enough_credits_for_test || @programme.user_completed?(current_user)

      attempts = @programme.assessment.assessment_attempts.where(user_id: current_user.id).order(:created_at)
      @num_attempts = attempts.count
      @can_take_test_at = 0
      @currently_taking_test = false

      if @num_attempts.positive?
        last_attempt = attempts.last
        if last_attempt.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_FAILED.to_s && @num_attempts >= 2
          @can_take_test_at = [last_attempt.last_transition.created_at.to_i - 48.hours.ago.to_i, 0].max
        elsif last_attempt.current_state == StateMachines::AssessmentAttemptStateMachine::STATE_COMMENCED.to_s
          @currently_taking_test = true
        end
      end
    end

    def user_enrolled?
      redirect_to "/#{@programme.slug}" unless @programme.user_enrolled?(current_user)
    end

    def get_certificate_details
      passed_achievements = current_user.achievements.for_programme(@programme).in_state('complete').joins(:activity)
                                        .where(activities: { category: 'assessment' })

      @transition = passed_achievements.last.last_transition if passed_achievements.any?
    end
end
