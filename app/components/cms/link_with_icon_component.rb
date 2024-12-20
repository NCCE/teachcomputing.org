# frozen_string_literal: true

class Cms::LinkWithIconComponent < ViewComponent::Base
  def initialize(link_text:, url:, icon:)
    @link_text = link_text
    @url = url
    @icon = icon
  end

  def call
    content_tag :div, class: "cms-icon-row" do
      concat(render(@icon.render))
      concat(link_to(@link_text, @url))
    end
  end
end
