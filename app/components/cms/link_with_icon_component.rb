# frozen_string_literal: true

class Cms::LinkWithIconComponent < ViewComponent::Base
  def initialize(link_text:, url:, icon: nil, additional_classes: nil)
    @link_text = link_text
    @url = url
    @icon = icon
    @additional_classes = additional_classes
  end

  def call
    content_tag :div, class: "cms-icon-row" do
      if @icon
        concat(render(@icon.render))
      end
      concat(link_to(@link_text, @url, class: @additional_classes))
    end
  end
end
