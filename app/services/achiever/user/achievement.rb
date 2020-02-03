class Achiever::User::Achievement
  RESOURCE_PATH = 'Set?Cmd=CreateNCCEAchievement'.freeze

  def initialize(record)
    @record = record
    @class_name = @record.class.to_s
  end

  def last_achievement_date
    return @record.last_transition.created_at if @record.state_machine.history.any?

    @record.created_at
  end

  def class_attributes
    case @class_name
    when 'Achievement'
      { 'Type' => @record.activity.slug,
        'Title' => @record.activity.title }
    when 'AssessmentAttempt'
      { 'Type' => "#{@record.assessment.programme.slug}-#{@record.assessment.activity.title}",
        'Title' => @record.assessment.activity.title }
    end
  end

  def request_body
    {
      'Entities' => [
        { 'CONTACTNO' => @record.user.stem_achiever_contact_no,
          'From' => last_achievement_date.strftime('%Y-%m-%d'),
          'State' => @record.current_state,
          'Notes' => @record.try(:last_transition).try(:metadata) }.merge(class_attributes)
      ]
    }.to_json
  end

  def sync
    Achiever::Request.post_resource(RESOURCE_PATH, request_body)
  end
end
