# frozen_string_literal: true

class Cms::SecondaryQuestionBankComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
    @records = begin
      Cms::Collections::SecondaryQuestionBankItems.all_records
    rescue ActiveRecord::RecordNotFound
      []
    end
  end

  def render?
    @records.any?
  end
end
