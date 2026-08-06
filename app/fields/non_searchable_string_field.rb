require "administrate/field/string"

class NonSearchableStringField < Administrate::Field::String
  def self.searchable?
    false
  end

  def self.local_partial_prefixes
    ["fields/string"]
  end
end
