namespace :non_enrolled_csa_user do
  task schedule: :environment do

    users = User.left_joins(:user_programme_enrolments).where(user_programme_enrolments: { id: nil })
    p = Programme.cs_accelerator

    non_enrolled_users = users.select do |u|
      u.achievements.for_programme(p).count.positive?
    end

    puts "#{users.count} total non-enrolled users. Sending email to: #{non_enrolled_users.count} from CSA\n"

    non_enrolled_users.each do |user|
      NonEnrolledCSAUserEmailJob.perform_now(user.id)
      print "."
    end

    puts "\nDone\n"
  end
end
