# frozen_string_literal: true

class CmsTextWithAsidesComponent < ViewComponent::Base
  def initialize(blocks:, asides:)
    @blocks = blocks
    @asides = asides
    @aside_models = @asides.map do |aside|
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
