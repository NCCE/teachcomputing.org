class UserProgrammeAchievements
  def initialize(programme, user)
    @achievements = user.achievements.for_programme(programme).sort_complete_first
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
    diagnostic_achievements = @achievements.with_category(Activity::ACTION_CATEGORY).where(activities: { slug: 'diagnostic-tool' })
    [DiagnosticPresenter.new(diagnostic_achievements.first)]
  end
end
