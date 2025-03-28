# frozen_string_literal: true

class Cms::AccordionBlockComponent < ViewComponent::Base
  erb_template <<~ERB
    <div class="govuk-accordion__section">
      <div class="govuk-accordion__section-header">
        <h2 class="govuk-accordion__section-heading">
          <span class="govuk-accordion__section-button">
            <%= @heading %>
          </span>
        </h2>
        <% if @summary_text %>
          <div class="govuk-accordion__section-summary govuk-body-s" id="accordion-with-summary-sections-summary">
            <%= @summary_text %>
          </div>
        <% end %>
      </div>
      <div id="accordion-default-content" class="govuk-accordion__section-content govuk-!-padding-bottom-4">
        <%= render @text_content.render  %>
      </div>
    </div>
  ERB

  def initialize(heading:, text_content:, summary_text: nil)
    @heading = heading
    @summary_text = summary_text
    @text_content = text_content
  end
end
