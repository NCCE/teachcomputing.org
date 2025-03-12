# frozen_string_literal: true

class Cms::PrimaryGlossaryTableComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
    @records = begin
      Cms::Collections::PrimaryGlossaryTableItems.all_records
    rescue ActiveRecord::RecordNotFound
      []
    end
  end

  def render?
    @records.any?
  end
end
