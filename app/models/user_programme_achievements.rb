class UserProgrammeAchievements
  def initialize(programme, user)
    @user = user
    @programme = programme
    @achievements = user.achievements.without_category('action')
                        .for_programme(programme).sort_complete_first
  end

  def online_achievements(to_show = 1)
    online_achievements = @achievements.not_in_state(:dropped).with_category(Activity::ONLINE_CATEGORY).order('created_at ASC')
    (0...to_show).to_a.map { |index| OnlinePresenter.new(online_achievements[index], @programme) }
  end

  def face_to_face_achievements(to_show = 1)
    face_to_face_achievements = @achievements.not_in_state(:dropped).with_category(Activity::FACE_TO_FACE_CATEGORY).order('created_at ASC')
    (0...to_show).to_a.map { |index| FaceToFacePresenter.new(face_to_face_achievements[index], @programme) }
  end

  def diagnostic_achievements
    diagnostic_achievements = @achievements.with_category(Activity::DIAGNOSTIC_CATEGORY)
    [DiagnosticPresenter.new(diagnostic_achievements.first)]
  end

  def community_activities(to_show = 1, credit = 5)
    activities = @programme.activities.community.joins("LEFT OUTER JOIN achievements on achievements.activity_id = activities.id AND achievements.user_id = '#{@user.id}'").where('credit = ?', credit).order('activities.credit')
    (0...to_show).to_a.map { |index| CommunityPresenter.new(activities[index], @programme.id) }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity

  def primary_community_activities(programme_activities:, pathway_activities: nil, complete: nil)
    activities = programme_activities

    if pathway_activities && !complete
      pathway_activities = programme_activities.select do |programme_activity|
        pathway_activities.pluck(:activity_id).include?(programme_activity.activity.id)
      end
      hidden_activities = programme_activities - pathway_activities
      activities = pathway_activities
    end

    activities = activities.sort_by { |a| @user.achievements.find_by(activity_id: a.activity_id)&.complete? ? 0 : 1 } if complete

    {
      activities: map_to_community_presenter(activities),
      hidden_activities: map_to_community_presenter(hidden_activities)
    }
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity

  def map_to_community_presenter(programme_activities)
    return unless programme_activities

    programme_activities.to_a.map { |programme_activity| CommunityPresenter.new(programme_activity.activity, @programme.id) }
  end

  def secondary_activities(programme_activities)
    programme_activities.to_a.map { |programme_activity| CommunityPresenter.new(programme_activity.activity, @programme.id) }
  end
end
