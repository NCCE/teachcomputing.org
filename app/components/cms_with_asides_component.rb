# frozen_string_literal: true

class CmsWithAsidesComponent < ViewComponent::Base
  attr_accessor :aside_models

  def initialize(aside_sections:)
    @aside_sections = aside_sections
    @aside_models = []

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
end