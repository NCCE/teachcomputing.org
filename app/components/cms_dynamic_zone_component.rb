# frozen_string_literal: true

class CmsDynamicZoneComponent < ViewComponent::Base
  def initialize(cms_models)
    @cms_models = cms_models
  end

  erb_template <<~ERB
    <div class="cms-dynamic-zone">
      <% @cms_models.each do |model| %>
        <%= render model.render %>
      <% end %>
    </div>
  ERB
end
