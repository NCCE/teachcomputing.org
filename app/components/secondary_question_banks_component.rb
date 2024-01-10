class SecondaryQuestionBanksComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(
    text: nil,
    bottom_margin: true,
    class_name: nil
  )
    @text = text
    @bottom_margin = bottom_margin
    @class_name = class_name
  end
end
