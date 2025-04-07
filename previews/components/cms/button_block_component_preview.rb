# frozen_string_literal: true

class Cms::ButtonBlockComponentPreview < ViewComponent::Preview
  def with_padding_not_full_width_left_align
    render(Cms::ButtonBlockComponent.new(
      buttons: Array.new(2) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model },
      background_color: nil,
      padding: true,
      full_width: false,
      alignment: "left"
    ))
  end

  def with_padding_full_width_center
    render(Cms::ButtonBlockComponent.new(
      buttons: Array.new(2) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model },
      background_color: nil,
      padding: true,
      full_width: true,
      alignment: "center"
    ))
  end

  def with_padding_not_full_width_center
    render(Cms::ButtonBlockComponent.new(
      buttons: Array.new(2) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model },
      background_color: nil,
      padding: true,
      full_width: false,
      alignment: "center"
    ))
  end

  def with_padding_full_width_right
    render(Cms::ButtonBlockComponent.new(
      buttons: Array.new(2) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model },
      background_color: nil,
      padding: true,
      full_width: true,
      alignment: "right"
    ))
  end

  def with_padding_not_full_width_right
    render(Cms::ButtonBlockComponent.new(
      buttons: Array.new(2) { Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model },
      background_color: nil,
      padding: true,
      full_width: false,
      alignment: "right"
    ))
  end
end
