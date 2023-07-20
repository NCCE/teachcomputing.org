# frozen_string_literal: true

require 'csv'

desc <<~DOC
  Reads a CSV file of user's stem_ids and marks their course as completed.

  One off task to be run approx July/August 2023
  Usage: bin/rails identify_qualified_teachers[users.csv, primary_certificate]
DOC

task :mark_teachers_as_completed, [:file, :certificate] => :environment do |_t, args|
  raise 'Argument must be primary_certificate or secondary_certificate' unless %w[primary_certificate secondary_certificate].include? args[:certificate]

  programme = Programme.send(args[:certificate])

  completed_user_count = 0

  CSV.foreach(args[:file]) do |row|
    user = User.find_by(stem_user_id: row[0])

    next unless programme&.user_meets_completion_requirement?(user)

    enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)

    next unless enrolment.present?
    next if enrolment&.current_state == :complete.to_s

    puts user.stem_user_id
    completed_user_count += 1

    enrolment.transition_to(:pending)
    ScheduleCertificateCompletionJob.perform_now(enrolment, {
      source: 'Rake rake task mark teachers as completed, https://github.com/NCCE/teachcomputing.org/pull/1747',
      reason: 'These are users who met the new relaxed requirements for completing primary and secondary courses'
    })
  end

  puts "Marked #{completed_user_count} users as completed."
  puts 'END OF OUTPUT'
end
