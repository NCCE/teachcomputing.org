class CSADash
  def initialize(user:, programme: nil)
    @user = user
    @programme = programme || Programme.cs_accelerator
  end

  def user_programme_pathway
    return @user_programme_pathway if defined? @user_programme_pathway

    @user_programme_pathway = @user.programme_pathway(@programme)
  end

  def compulsory_achievement
    return @compulsory_achievement if defined? @compulsory_achievement

    @compulsory_achievement = @programme.compulsory_achievement(@user)
  end

  def non_compulsory_achievements
    return @non_compulsory_achievements if defined? @non_compulsory_achievements

    @non_compulsory_achievements = @programme.non_compulsory_achievements(@user)
  end

  def user_completed_non_compulsory_achievement?
    @user_completed_non_compulsory_achievement ||= @programme.user_completed_non_compulsory_achievement?(@user)
  end

  def other_programme_pathways_for_user
    @other_programme_pathways_for_user ||= @programme.pathways_excluding(user_programme_pathway)
  end

  def recommended_activities_for_user
    return @recommended_activities_for_user if defined? @recommended_activities_for_user

    @recommended_activities_for_user = user_programme_pathway&.recommended_activities_for_user(@user)
  end

  def has_enough_activities_for_test
    @has_enough_activities_for_test ||= @programme.enough_activities_for_test?(@user)
  end

  def user_programme_assessment
    @user_programme_assessment ||= UserProgrammeAssessment.new(@programme, @user)
  end
end
