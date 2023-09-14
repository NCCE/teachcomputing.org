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
    when 'twitter', 'x'
      "https://twitter.com/#{@value}"
    end
  end

  def tracking_data
    {
      event_action: 'click',
      event_category: 'Hubs',
      event_label: "Hub #{@type}"
    }
  end

  def image_path
    case @type
    when 'website', 'facebook'
      "media/images/social-media/#{@type}.svg"
    when 'twitter', 'x'
      "media/images/social-media/x_grey.svg"
    end
  end

  def render?
    @value.present?
  end
end
