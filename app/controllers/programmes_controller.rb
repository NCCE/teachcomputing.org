class ProgrammesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :find_programme, only: %i[show complete certificate]
  before_action :user_enrolled?, only: %i[show complete certificate]
  before_action :user_completed_diagnostic?, only: %i[show], if: -> { @programme.slug == 'primary-certificate' }
  before_action :store_internal_location, only: %i[show], if: -> { @programme.slug == 'primary-certificate' }

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

    render "programmes/#{@programme.slug}/complete"
  end

  def certificate
    return redirect_to programme_path(@programme.slug) unless @programme.user_completed?(current_user)

    get_certificate_details
    render "programmes/#{@programme.slug}/certificate", layout: 'certificate'
  end

  private

    def user_completed_diagnostic?
      return true if @programme.user_completed_diagnostic?(current_user)

      redirect_to primary_certificate_diagnostic_path(:introduction)
    end

    def find_programme
      @programme = Programme.enrollable.find_by!(slug: params[:slug])
    end

    def user_enrolled?
      redirect_to "/#{@programme.slug}" unless @programme.user_enrolled?(current_user)
    end

    def get_certificate_details
      passed_achievements = current_user.achievements.for_programme(@programme).in_state('complete')
      @transition = passed_achievements.last.last_transition if passed_achievements.any?
    end
end
