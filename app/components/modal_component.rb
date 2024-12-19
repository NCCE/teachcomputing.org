class ModalComponent < ViewComponent::Base
  renders_one :header
  renders_one :body
  renders_one :close_button
  renders_one :reopen_button
  renders_one :confirmation # are you sure?

  attr_reader :expanded, :title, :reopen_button_text, :show_corner_decoration, :class_name, :reopen_button_class, :modal_id

  def initialize(title:, expanded: false, reopen_button_text: nil, show_corner_decoration: true, class_name: nil, reopen_button_class: nil, z_index: 1000, modal_id: SecureRandom.hex(6), data: {})
    super
    @expanded = expanded
    @title = title
    @reopen_button_text = reopen_button_text
    @show_corner_decoration = show_corner_decoration
    @class_name = class_name
    @reopen_button_class = reopen_button_class
    @z_index = z_index
    @modal_id = modal_id
    @data = data
  end

  def data
    @data.merge({
      controller: "modal",
      modal_confirm_value: "true",
      modal_modal_id_value: @modal_id
    })
  end

  def z_index
    "--z-index: #{@z_index};"
  end
end
