require "administrate/field/base"

class AchievementListField < Administrate::Field::Base
  def state_list
    StateMachines::AchievementStateMachine.states.map { [_1.humanize, _1] }
  end

  def to_s
    data
  end
end
