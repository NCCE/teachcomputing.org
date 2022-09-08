class AssessmentMailerPreview < ActionMailer::Preview
  def failed__disabled
    AssessmentMailer.with(user_id: User.first.id).failed
  end
end
