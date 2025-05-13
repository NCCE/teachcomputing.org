# frozen_string_literal: true

class Cms::SiteWideBannerComponent < ViewComponent::Base
  erb_template <<~ERB
    <div class="cms-site-wide-banner-component">
      <span class="govuk-body-s"><%= render @current_notification.text_content.render %></span>
    </div>
  ERB

  def initialize(current_notification:)
    @current_notification = current_notification
  end

  def render?
    @current_notification
  end
end
