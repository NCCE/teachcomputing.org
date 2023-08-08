require 'sti_preload'

class EnrichmentGrouping < ApplicationRecord
  include StiPreload

  belongs_to :programme

  with_options presence: true do
    validates :title
    validates :programme
  end
end
