# frozen_string_literal: true

class HubSocialLinkComponent < ViewComponent::Base
  def initialize(type:, value:)
    @type = type
    @value = value
  end

  def social_link
    case @type
    when 'website'
      @value
    when 'facebook'
      "https://facebook.com/#{@value}"
    when 'twitter'
      "https://twitter.com/#{@value}"
    end
  end

  def render?
    @value.present?
  end
end
