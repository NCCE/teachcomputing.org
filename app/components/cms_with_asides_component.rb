# frozen_string_literal: true

class CmsWithAsidesComponent < ViewComponent::Base
  attr_accessor :aside_models

  def initialize(aside_sections:)
    @aside_sections = aside_sections
    @aside_models = []
    @hidden_asides = []

    if @aside_sections
      @aside_models = @aside_sections.map do |aside|
        slug = aside[:slug]
        begin
          {
            id: slug,
            model: Cms::Collections::AsideSection.get(slug)
          }
        rescue ActiveRecord::RecordNotFound => e
          raise(e) if Rails.env.development?
          {id: aside[:slug], model: nil}
        end
      end
    end
  end

  def not_hidden(aside)
    !@hidden_asides.include?(aside[:id])
  end

  def hide_aside(slug)
    @hidden_asides << slug
  end
end
