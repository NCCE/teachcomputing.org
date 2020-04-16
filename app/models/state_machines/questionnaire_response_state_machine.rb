class StateMachines::QuestionnaireResponseStateMachine
  include Statesman::Machine

  state :in_progress, initial: true
  state :complete

  transition from: :in_progress, to: %i[complete]
end
