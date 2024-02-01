class ModalComponentPreview < ViewComponent::Preview
  def default
    render ModalComponent.new(title: "Modal title", reopen_button_text: "Open me!") do |component|
      component.with_body do
        %(
<p class="govuk-body">
  We have recently updated our Primary computing certificate pathways to better align to your development needs and goals. You are now enrolled on the updated pathway, but can still change to an alternative pathway at any point.
</p>
<p class="govuk-body">
  For any questions about the primary certificate, get in touch:
</p>
        ).html_safe
      end
    end
  end

  def expanded_on_page_load
    render ModalComponent.new(title: "Modal title", reopen_button_text: "Open me!", expanded: true) do |component|
      component.with_body do
        %(
<p class="govuk-body">
  We have recently updated our Primary computing certificate pathways to better align to your development needs and goals. You are now enrolled on the updated pathway, but can still change to an alternative pathway at any point.
</p>
<p class="govuk-body">
  For any questions about the primary certificate, get in touch:
</p>
        ).html_safe
      end
    end
  end

  def custom_close_button
    render ModalComponent.new(title: "Modal title", reopen_button_text: "Open me!", expanded: true) do |component|
      component.with_body do
        %(
<p class="govuk-body">
  We have recently updated our Primary computing certificate pathways to better align to your development needs and goals. You are now enrolled on the updated pathway, but can still change to an alternative pathway at any point.
</p>
<p class="govuk-body">
  For any questions about the primary certificate, get in touch:
</p>
        ).html_safe
      end
      component.with_close_button do
        '<p class="govuk-body" data-action="click->modal#toggle">Close</p>'.html_safe
      end
    end
  end
end
