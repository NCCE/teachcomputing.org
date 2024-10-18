# frozen_string_literal: true

class CmsDynamicZoneComponent < ViewComponent::Base
  def initialize(cms_models:, with_spacing: true)
    @cms_models = cms_models
    @with_spacing = with_spacing
  end

  def wrapper_classes
    classes = ["cms-dynamic-zone"]
    classes += ["govuk-!-margin-bottom-7", "govuk-!-margin-top-7"] if @with_spacing
    classes.join(" ")
  end

  erb_template <<~ERB
    <div class="<%= wrapper_classes %>">
      <% @cms_models.each do |model| %>
        <%= render model.render %>
      <% end %>
    </div>
  ERB
end
