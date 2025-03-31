class CSADash
  def initialize(user:, programme: nil)
    @user = user
    @programme = programme || Programme.cs_accelerator
  end

  def user_programme_pathway
    @user_programme_pathway ||= @user.programme_pathway(@programme)
  end

  def course_achievements
    @course_achievements ||= @programme.course_achievements(@user)
  end

  def other_programme_pathways_for_user
    @other_programme_pathways_for_user ||= @programme.pathways_excluding(user_programme_pathway)
  end

  def recommended_activities_for_user
    @recommended_activities_for_user ||= user_programme_pathway&.recommended_activities_for_user(@user)
  end

  def has_enough_activities_for_test
    @has_enough_activities_for_test ||= @programme.enough_credits_for_test?(@user)
  end

  def user_programme_assessment
    @user_programme_assessment ||= UserProgrammeAssessment.new(@programme, @user)
  end
end
