# frozen_string_literal: true

class HeroComponent < ViewComponent::Base
  include ViewComponent::Translatable

  def initialize(title:, color: nil, glyph: :a1, small_title: false, subtitle: nil, status: nil)
    @title = title
    @glyph = glyph
    @color = color
    @small_title = small_title
    @subtitle = subtitle
    @status = status
  end

  def class_list
    ['hero-component',
     color_class,
     glyph_class].compact.join(' ')
  end

  def heading_class_list
    "#{heading_size_class} hero-component__heading"
  end

  private

    def color_class
      return 'hero-component__default' unless @color.present?

      "hero-component__#{@color}"
    end

    def glyph_class
      "hero-component__glyph-#{@glyph}"
    end

    def heading_size_class
      return 'govuk-heading-l' if @small_title

      'govuk-heading-xl'
    end
end
