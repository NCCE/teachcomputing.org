class StateMachines::AchievementStateMachine
  include Statesman::Machine

  state :commenced, initial: true
  state :complete

  transition from: :commenced, to: :complete

  before_transition(from: :commenced, to: :complete) do |achievement, _transition|
    # Debug to illustrate how we might use this in future
    a = achievement.activity
    puts "before_transition - activity: (#{a.id}) #{a.title} = #{a.credit}"
  end
end
