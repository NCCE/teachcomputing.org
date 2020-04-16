class CsChangesController < ApplicationController
  layout 'full-width'
  before_action :authenticate_user!
  before_action :find_programme, only: %i[show]
  before_action :user_enrolled?, only: %i[show]

  def show
    @programme = Programme.cs_accelerator
    @online_achievements = current_user.achievements.for_programme(@programme)
                                       .with_category(Activity::ONLINE_CATEGORY)
    @face_to_face_achievements = current_user.achievements.for_programme(@programme)
                                             .with_category(Activity::FACE_TO_FACE_CATEGORY)

    @user_programme_assessment = UserProgrammeAssessment.new(@programme, current_user)

    render :show
  end

  private

  def find_programme
    @programme = Programme.enrollable.find_by!(slug: params[:slug])
  end

  def user_enrolled?
    redirect_to "/#{@programme.slug}" unless @programme.user_enrolled?(current_user)
  end
end
