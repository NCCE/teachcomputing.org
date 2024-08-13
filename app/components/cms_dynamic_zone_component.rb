# frozen_string_literal: true

class CmsDynamicZoneComponent < ViewComponent::Base
  def initialize(components)
    @components = components
  end

  erb_template <<~ERB
    <div class="cms-dynamic-zone">
      <% @components.each do |comp| %>
        <%= render comp.render %>
      <% end %>
    <div>
  ERB
end
