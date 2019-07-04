namespace :cs_accelerator do
  task add_external_graduates: :environment do
    programme = Programme.find_by!(slug: 'cs-accelerator')

    puts "Programme: #{programme.inspect}"

    test_takers = [
      { email: 'web@raspberrypi.org', percentage: 70.0 },
      { email: 'tor_deavall@yahoo.co.uk', percentage: 72.0 },
      { email: 'ntarrant@robertsbridge.org.uk', percentage: 72.0 },
      { email: 'a.j.tomkins@gmail.com', percentage: 64.0 },
      { email: 'a.j.tomkins@gmail.com', percentage: 68.0 },
      { email: ' shelley.cadman@mybiddenham.com', percentage: 72.0 },
      { email: 'g2ewl@hotmail.co.uk', percentage: 24.0 },
      { email: 'barnesr@bedalehighschool.org.uk', percentage: 92.0 },
      { email: 'lrussell@bradfield.sheffield.sch.uk', percentage: 52.0 },
      { email: 'dpeacefield@oakwood.surrey.sch.uk', percentage: 64.0 },
      { email: 'mellis@qegs.cumbria.sch.uk', percentage: 84.0 },
      { email: 'shelley.cadman@mybiddenham.com', percentage: 64.0 },
      { email: 'castbury@swaveseyvc.co.uk', percentage: 56.0 },
      { email: 'pfk@maltonschool.org', percentage: 68.0 },
      { email: 'gss@maltonschool.org', percentage: 80.0 },
      { email: 'lrussell@bradfield.sheffield.sch.uk', percentage: 0.0 },
      { email: 'weaverd@harpergreen.net', percentage: 72.0 },
      { email: 'pclark@sbch.org.uk', percentage: 72.0 }
    ]

    assessment = Assessment.find_by!(programme_id: programme.id)

    puts "Assessment: #{assessment.inspect}"

    test_takers.each do |test_taker|
      email = test_taker[:email]
      user = User.find_by(email: email)
      next unless user

      puts "User #{email}..."
      achievement = assessment.activity.achievements.find_or_initialize_by(user_id: user.id)
      if achievement.current_state == 'complete'
        puts "...has already completed the certificate on: #{achievement.last_transition.created_at} with certificate_number: #{achievement.last_transition.metadata['certificate_number']}"
        next
      end

      achievement.save
      assessment_attempt = AssessmentAttempt.new(assessment_id: assessment.id, user_id: user.id)
      assessment_attempt.save
      percentage = test_taker[:percentage]
      if percentage.to_f >= 65.0
        assessment_attempt.transition_to(:passed, percentage: percentage.to_f)
        certificate_number = assessment.assessment_counter.get_next_number
        achievement.set_to_complete(certificate_number: certificate_number)
        puts "...has passed with #{percentage}% - certificate_number: #{certificate_number}"
      else
        puts "...has failed with #{percentage}%"
        assessment_attempt.transition_to(:failed, percentage: percentage.to_f)
      end
    end
  end
end
