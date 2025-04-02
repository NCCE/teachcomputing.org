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

  def box_classes(key_stage)
    classes = ["curriculum-card"]
    classes << if ["1", "2"].include?(key_stage.level)
      cms_color_theme_class("orange", "left")
    else
      cms_color_theme_class("green", "left")
    end
  end

  def render?
    @key_stages.any?
  end
end
