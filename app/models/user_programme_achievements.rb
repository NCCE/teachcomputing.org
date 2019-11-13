class UserProgrammeAchievements
  def initialize(programme, user)
    @user = user
    @achievements = user.achievements.without_category('action')
                                     .for_programme(programme).sort_complete_first
  end

  def online_achievements(to_show = 1)
    online_achievements = @achievements.with_category(Activity::ONLINE_CATEGORY)
    (0...to_show).to_a.map { |index| OnlinePresenter.new(online_achievements[index]) }
  end

  def face_to_face_achievements(to_show = 1)
    face_to_face_achievements = @achievements.with_category(Activity::FACE_TO_FACE_CATEGORY)
    (0...to_show).to_a.map { |index| FaceToFacePresenter.new(face_to_face_achievements[index]) }
  end

  def diagnostic_achievements
    diagnostic_achievements = @achievements.with_category(Activity::DIAGNOSTIC_CATEGORY)
    [DiagnosticPresenter.new(diagnostic_achievements.first)]
  end

  def community_activities(to_show = 1, credit = 5)
    activities = Activity.community.joins("LEFT OUTER JOIN achievements on achievements.activity_id = activities.id AND achievements.user_id = '#{@user.id}'").where("credit = #{credit}").order('activities.credit')
    (0...to_show).to_a.map { |index| CommunityPresenter.new(activities[index])}
  end
end
