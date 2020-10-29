class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :find_programme, only: %i[show complete pending]
  before_action :user_enrolled?, only: %i[show complete pending]
  before_action :user_completed_diagnostic?, only: %i[show], if: -> { @programme.slug == 'primary-certificate' }

  # is this being tested?
  before_action :user_programme_enrolment_pending?, only: %i[show complete], if: -> { @programme.slug == 'primary-certificate' }

  def show
    return redirect_to programme_complete_path(@programme.slug) if @programme.user_completed?(current_user)

    @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)

    if @programme.slug == 'cs-accelerator'
      @online_achievements = current_user.achievements.for_programme(@programme)
                                         .not_in_state(:dropped)
                                         .with_category(Activity::ONLINE_CATEGORY)
      @face_to_face_achievements = current_user.achievements.for_programme(@programme)
                                               .not_in_state(:dropped)
                                               .with_category(Activity::FACE_TO_FACE_CATEGORY)
      render "programmes/#{@programme.slug}/show"
    else
      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
      render "programmes/#{@programme.slug}/show"
    end
  end

  def complete
    return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

    if @programme.slug == 'cs-accelerator'
      @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)
      @online_achievements = current_user.achievements.for_programme(@programme)
                                         .not_in_state(:dropped)
                                         .with_category(Activity::ONLINE_CATEGORY)
      @face_to_face_achievements = current_user.achievements.for_programme(@programme)
                                               .not_in_state(:dropped)
                                               .with_category(Activity::FACE_TO_FACE_CATEGORY)
    else
      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)

      @complete_achievements = current_user.achievements.without_category('action')
                                           .without_category('diagnostic')
                                           .for_programme(@programme).sort_complete_first
    end

    render "programmes/#{@programme.slug}/complete"
  end

  def pending
    return redirect_to programme_complete_path(@programme.slug) if enrolment.current_state == 'complete'

    if @programme.slug == 'primary-certificate'
      @complete_achievements = current_user.achievements.without_category('action')
                                           .without_category('diagnostic')
                                           .for_programme(@programme).sort_complete_first
    end

    @enrolment = current_user.user_programme_enrolments.find_by(programme_id: @programme.id)

    render "programmes/#{@programme.slug}/pending"
  end

  private

    def enrolment
      current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
    end

    def find_programme
      @programme = Programme.enrollable.find_by!(slug: params[:slug])
    end

    def user_completed_diagnostic?
      questionnaire = Questionnaire.find_by(slug: 'primary-certificate-enrolment-questionnaire')
      response = QuestionnaireResponse.find_by(user: current_user, questionnaire: questionnaire)
      return true if response && response.current_state == 'complete'

      # Navigate directly to the last question reached, or question_1.
      question = response&.current_question ? "question_#{response.current_question}" : 'question_1'
      redirect_to diagnostic_primary_certificate_path(question.to_sym)
    end

    def user_enrolled?
      redirect_to "/#{@programme.slug}" unless @programme.user_enrolled?(current_user)
    end

    def user_programme_enrolment_pending?
      redirect_to programme_pending_path(@programme.slug) if enrolment.current_state == 'pending'
    end
end
