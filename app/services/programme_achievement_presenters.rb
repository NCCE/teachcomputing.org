class ProgrammeAchievementPresenters
  attr_reader :online_achievements
  attr_reader :face_to_face_achievements
  attr_reader :diagnostic_achievements

  def create(programme, user)
    achievements = user.achievements.for_programme(programme).sort_complete_first

    @online_achievements = achievements.with_category('online')
    @online_achievements = [0, 1].map { |index| OnlinePresenter.new(@online_achievements[index]) }

    @face_to_face_achievements = achievements.with_category('face-to-face')
    @face_to_face_achievements = [0, 1].map { |index| FaceToFacePresenter.new(@face_to_face_achievements[index]) }

    @diagnostic_achievements = achievements.with_category('action').where(activities: { slug: 'diagnostic-tool' })
    @diagnostic_achievements = [DiagnosticPresenter.new(@diagnostic_achievements.first)]
  end
end
