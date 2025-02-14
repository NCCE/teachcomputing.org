# frozen_string_literal: true

class Cms::DynamicZoneComponent < ViewComponent::Base
  def initialize(cms_models:)
    @cms_models = cms_models
  end

  def needs_padding?
    @cms_models.any? { _1.instance_of?(Cms::DynamicComponents::StickyDashboardBar) }
  end

  def classes
    classes = ["cms-dynamic-zone"]
    classes << ["cms-dynamic-zone--bottom-padding"] if needs_padding?
    classes.join(" ")
  end

  erb_template <<~ERB
    <div class="<%= classes %>">
      <% @cms_models.each do |model| %>
        <%= render model.render %>
      <% end %>
    </div>
  ERB
end
