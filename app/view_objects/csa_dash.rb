class CSADash
  def initialize(user:)
    @user = user
    @programme = Programme.cs_accelerator
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

  def non_compulsory_achievement_courses
    return @non_compulsory_achievement_courses if defined? @non_compulsory_achievement_courses

    @non_compulsory_achievement_courses ||= begin
      activity_codes = non_compulsory_achievements.map do |a|
        a.activity.stem_activity_code
      end
      Achiever::Course::Template.find_many_by_activity_codes(activity_codes)
    end
  end

  def user_completed_non_compulsory_achievement?
    @user_completed_non_compulsory_achievement ||= @programme.user_completed_non_compulsory_achievement?(@user)
  end

  def other_programme_pathways_for_user
    @other_programme_pathways_for_user ||= @programme.pathways_excluding(user_programme_pathway).ordered
  end
end
