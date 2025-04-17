# frozen_string_literal: true

class Cms::SiteWideBannerComponent < ViewComponent::Base
  erb_template <<~ERB
    <div class="cms-site-wide-banner-component">
      <span class="govuk-body-s"><%= render @text_content.render %></span>
    </div>
  ERB

  def initialize(text_content:)
    @text_content = text_content
  end
end
