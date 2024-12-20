require "administrate/field/base"

class ValidStatePickerField < Administrate::Field::Base
  def valid_states_for_change
    if resource.new_record?
      resource.state_machine.class.states
    else
      resource.allowed_transitions
    end
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
