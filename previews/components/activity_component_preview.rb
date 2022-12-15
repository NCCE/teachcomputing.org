# frozen_string_literal: true

class ActivityComponentPreview < ViewComponent::Preview
  def default
    render(ActivityComponent.new(objective: 'objective', description: 'description', button: 'button'))
  end
end
