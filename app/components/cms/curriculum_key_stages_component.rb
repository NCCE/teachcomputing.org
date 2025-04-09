# frozen_string_literal: true

class Cms::CurriculumKeyStagesComponent < ViewComponent::Base
  delegate :cms_color_theme_class, to: :helpers

  def initialize(title:, background_color:)
    @title = title
    @background_color = background_color

    @key_stages = begin
      CurriculumClient::Queries::KeyStage.all.key_stages
    rescue
      []
    end
  end

  def box_classes
    ["curriculum-card", cms_color_theme_class("green", "left")]
  end

  def render?
    @key_stages.any?
  end
end
