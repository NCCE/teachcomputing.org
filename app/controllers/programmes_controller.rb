class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :find_programme, only: %i[show complete certificate pending]
  before_action :user_enrolled?, only: %i[show complete certificate pending]
  before_action :user_completed_diagnostic?, only: %i[show], if: -> { @programme.slug == 'primary-certificate' }
  before_action :user_programme_enrolment_pending?, only: %i[show complete certificate], if: -> { @programme.slug == 'primary-certificate' }

  def show
    return redirect_to programme_complete_path(@programme.slug) if @programme.user_completed?(current_user)

    @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
    @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)

    render "programmes/#{@programme.slug}/show"
  end

  def complete
    return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

    @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)
    @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)

    @complete_achievements = current_user.achievements.for_programme(@programme).sort_complete_first if @programme.slug == 'primary-certificate'

    render "programmes/#{@programme.slug}/complete"
  end

  def certificate
    return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

    get_certificate_details
    render "programmes/#{@programme.slug}/certificate", layout: 'certificate'
  end

  def pending
    return redirect_to programme_complete_path(@programme.slug) if enrolment.current_state == 'complete'

    @complete_achievements = current_user.achievements.for_programme(@programme).sort_complete_first
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

    def get_certificate_details
      @transition = enrolment.last_transition
    end

    def user_completed_diagnostic?
      return true if @programme.user_completed_diagnostic?(current_user)

      redirect_to primary_certificate_diagnostic_path(:question_1)
    end

    def user_enrolled?
      redirect_to "/#{@programme.slug}" unless @programme.user_enrolled?(current_user)
    end

    def user_programme_enrolment_pending?
      redirect_to programme_pending_path(@programme.slug) if enrolment.current_state == 'pending'
    end
end
