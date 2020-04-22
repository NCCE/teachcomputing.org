
# every :weekday, at: "9:00 AM" do
#   runner "ScheduleUserResourcesFeedbackJob"
# end

every 1.minute do
  command "echo checking it"
end

every 1.minute do
  command "/usr/bin/my_super_command", mailto: 'magdalena@raspberrypi.com'
end