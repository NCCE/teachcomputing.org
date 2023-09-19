# frozen_string_literal: true

class HubSocialLinkComponent < ViewComponent::Base
  def initialize(type:, value:)
    @type = type
    @value = value
  end

  def social_link
    case @type
    when 'website', 'linkedin'
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
    when 'linkedin'
      "media/images/social-media/linkedin.png"
    end
  end

  def image_class
    case @type
    when 'x'
      'hub-social-link-component__x'
    when 'linkedin'
      'hub-social-link-component__linkedin'
    end
  end

  def render?
    @value.present?
  end
end
