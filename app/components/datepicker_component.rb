# frozen_string_literal: true

class DatepickerComponent < ViewComponent::Base
  # flatpickr: options to be forwarded to flatpickr
  # options: override html options
  def initialize(name, value = nil, flatpickr: {}, options: {}, input_options: {})
    @name = name
    @value = value
    @flatpickr = flatpickr
    @options = options
    @input_options = input_options
  end

  def controllerOptions
    {
      data: {
        controller: "flatpickr",
        flatpickr_options_value: @flatpickr.to_json
      },
      class: ["flatpickr"]
    }.deep_merge!(@options)
  end

  def inputOptions
    {
      data: {
        flatpickr_target: "input"
      },
      class: "govuk-input"
    }.deep_merge!(@input_options)
  end
end
