class DatepickerComponentPreview < ViewComponent::Preview
  def date_range_mode
    render(DatepickerComponent.new(
      "date_range",
      nil,
      flatpickr: {mode: "range"},
      input_options: {placeholder: "Select a date or date range"}
    ))
  end
end
