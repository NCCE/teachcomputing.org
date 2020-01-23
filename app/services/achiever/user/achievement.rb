class Achiever::User::Achievement
  RESOURCE_PATH = 'Set?Cmd=CreateNCCEAchievement'.freeze

  def initialize(achievement)
    @achievement = achievement
  end

  def last_achievement_date
    return @achievement.last_transition.created_at if @achievement.state_machine.history.any?

    @achievement.created_at
  end

  def request_body
    {
      'Entities' => [
        { 'CONTACTNO' => @achievement.user.stem_achiever_contact_no,
          'From' => last_achievement_date,
          'Type' => '',
          'State' => @achievement.current_state,
          'Notes' => @achievement.try(:last_transition).try(:metadata),
          'Title' => @achievement.activity.title }
      ]
    }.to_json
  end

  def sync
    Achiever::Request.post_resource(RESOURCE_PATH, request_body)
  end
end
