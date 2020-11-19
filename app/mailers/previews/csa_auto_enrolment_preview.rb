# Preview all emails at http://localhost:3000/rails/mailers/csa_auto_enrolment
class CSAAutoEnrolmentPreview < ActionMailer::Preview
  def welcome
    CSAAutoEnrolmentMailer.with(user: User.first).welcome
  end
end
