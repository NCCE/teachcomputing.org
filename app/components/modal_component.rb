class ModalComponent < ViewComponent::Base
  renders_one :body

  attr_reader :expanded, :title, :reopen_button_text

  def initialize(expanded: false, title:, reopen_button_text: nil)
    @expanded = expanded
    @title = title
    @reopen_button_text = reopen_button_text
  end
end
