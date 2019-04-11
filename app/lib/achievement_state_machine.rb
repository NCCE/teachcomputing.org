class AchievementStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :complete

  transition from: :enrolled, to: :complete

  before_transition(from: :enrolled, to: :complete) do |achievement, transition|
    puts "before_transition - activity: #{achievement.activity.title} = #{achievement.activity.credit}"
  end
end
