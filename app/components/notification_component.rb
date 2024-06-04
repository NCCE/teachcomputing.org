# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(user:, wrapper_css: "", preview: false)
    @preview = preview
    @user = user
    @notifiable_programmes = filter_programmes(user)
    @wrapper_css = wrapper_css
  end

  def render?
    return false if @user.blank?

    @notifiable_programmes.any?
  end

  private

  def filter_programmes(user)
    return [] if user.blank?
    return [user.programmes.last] if @preview

    user.programmes.select do |programme|
      programme.show_notification_for_test?(user)
    end
  end
end
