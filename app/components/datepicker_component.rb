# frozen_string_literal: true

class DatepickerComponent < ViewComponent::Base
  # flatpickr: options to be forwarded to flatpickr
  # options: override html options
  def initialize(name, value = nil, flatpickr: {}, options: {})
    @name = name
    @value = value
    @flatpickr = flatpickr
    @options = options
  end

  def controllerOptions
    {
      data: {
        controller: "flatpickr",
        flatpickr_options_value: @flatpickr.to_json
      }
    }.deep_merge!(@options)
  end

  def inputOptions
    {
      data: {
        flatpickr_target: "input"
      },
      class: "govuk-input"
    }
  end
end
