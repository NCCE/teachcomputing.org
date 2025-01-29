# frozen_string_literal: true

class ProgrammeStatusComponent < ViewComponent::Base
  def initialize(user_programme_enrolment:)
    @user_programme_enrolment = user_programme_enrolment
    @cms_programme_model = Cms::Collections::Programme.get(@user_programme_enrolment.programme.slug)
  end

  def render?
    @user_programme_enrolment.in_state?(:pending) || @user_programme_enrolment.in_state?(:complete)
  end

  def title
    if @user_programme_enrolment.in_state?(:pending)
      @cms_programme_model.status_pending_title.value
    else
      @cms_programme_model.status_completed_title.value
    end
  end

  def content
    if @user_programme_enrolment.in_state?(:pending)
      @cms_programme_model.status_pending_text
    else
      @cms_programme_model.status_completed_text
    end
  end
end
