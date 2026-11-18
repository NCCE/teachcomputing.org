# frozen_string_literal: true

class TickListComponent < ViewComponent::Base
  def initialize(tick_list:, title: nil, text: nil, bullets: nil, button: nil,
    class_name: nil)
    raise(ArgumentError, "TickListComponent needs a tick_list to render") if tick_list.blank?

    @title = title || tick_list[:title]
    @text = text || tick_list[:text]
    @bullets = bullets || tick_list[:bullets]
    @button = button || tick_list[:button]
    @class_name = class_name || tick_list[:class_name]
  end
end
