class ModalComponent < ViewComponent::Base
  renders_one :body
  renders_one :close_button

  attr_reader :expanded, :title, :reopen_button_text, :show_corner_decoration, :class_name, :reopen_button_class

  def initialize(title:, expanded: false, reopen_button_text: nil, show_corner_decoration: true, class_name: nil, reopen_button_class: nil)
    @expanded = expanded
    @title = title
    @reopen_button_text = reopen_button_text
    @show_corner_decoration = show_corner_decoration
    @class_name = class_name
    @reopen_button_class = reopen_button_class
  end
end
