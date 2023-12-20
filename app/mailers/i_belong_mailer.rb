class IBelongMailer < ApplicationMailer
  before_action :assign_user

  def completed
    @subject = "Congratulations on your achievement #{@user.full_name}"

    mail(to: @user, subject: @subject)
  end

  def pending
    @subject = 'Thank you for participating in the I Belong programme'

    mail(to: @user, subject: @subject)
  end

  def welcome
    @subject = 'Welcome to I Belong: Encouraging girls into computer science!'

    mail(to: @user, subject: @subject)
  end

  def inactive_not_completed_any_sections
    @subject = 'Reminder: update your progress on the I Belong programme'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: InactivityQueries.no_activities_completed_type(Programme.i_belong.slug))
  end

  def inactive_only_completed_one_section
    @subject = 'Reminder: update your progress on the I Belong programme'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: InactivityQueries.i_belong_only_one_section_completed_type)
  end

  def inactive_everything_but_understanding_factors
    @subject = 'You\'re nearly there'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: InactivityQueries.i_belong_all_but_understanding_factors_type)
  end

  def inactive_everything_but_access_resources
    @subject = 'You\'re so close'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: InactivityQueries.i_belong_all_but_access_resources_type)
  end

  def inactive_everything_but_increase_engagement
    @subject = 'You\'re almost there'

    mail(to: @user, subject: @subject, record_sent_mail: true, mailer_type: InactivityQueries.i_belong_all_but_increase_engagement_type)
  end

  private

    def assign_user
      @user = params[:user]
    end
end
