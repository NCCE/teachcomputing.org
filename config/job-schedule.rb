
# every :weekday, at: "9:00 AM" do
#   runner "ScheduleUserResourcesFeedbackJob"
# end

require 'sidekiq-scheduler'

class HelloWorld
  include Sidekiq::Worker
  def perform
    puts 'Hello world!'
  end
end