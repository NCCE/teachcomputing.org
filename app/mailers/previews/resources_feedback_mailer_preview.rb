class ResourcesFeedbackMailerPreview < ActionMailer::Preview
  def feedback_request
    user = User.last
    ResourcesFeedbackMailer.with(user: user, year: '3').feedback_request
  end
end
