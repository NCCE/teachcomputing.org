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
          <div class="govuk-accordion__section-summary govuk-body-s" id="accordion-with-summary-sections-summary-<%= @index %>">
            <%= @summary_text %>
          </div>
        <% end %>
      </div>
      <div id="accordion-default-content-<%= @index %>" class="govuk-accordion__section-content govuk-!-padding-bottom-2">
        <%= render @text_content.render  %>
      </div>
    </div>
  ERB

  def initialize(heading:, summary_text:, text_content:, index:)
    @heading = heading
    @summary_text = summary_text
    @text_content = text_content
    @index = index
  end
end
