require "administrate/field/base"

class ValidStatePickerField < Administrate::Field::Base
  def valid_states_for_change
    resource.allowed_transitions
  end

  def name
    "Current State"
  end

  def to_s
    data.to_s
  end

  def self.permitted_attribute(attr, _options = {})
    nil
  end
end
