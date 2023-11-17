class EnrichmentEntry < ApplicationRecord
  has_one_attached :logo

  belongs_to :enrichment_grouping

  with_options presence: true do
    validates :title
    validates :body
    validates :order
  end
end
