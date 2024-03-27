class AssessmentMailerPreview < ActionMailer::Preview
  def failed__disabled
    AssessmentMailer.with(user_id: User.first.id, preview: true).failed
  end
end
