# frozen_string_literal: true

require 'factory_bot_rails'
require 'faker'

class CommunityActivityComponentPreview < ViewComponent::Preview
  def default
    render(CommunityActivityComponent.new(activity: FactoryBot.create(:activity)))
  end
end
