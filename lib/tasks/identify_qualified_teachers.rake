# frozen_string_literal: true

desc <<~DOC
  Output stem user id and email address of teachers qualified for a certificate.

  One off task to be run approx June/July 2023
  Usage: bin/rails identify_qualified_teachers[primary_certificate]
DOC

task :identify_qualified_teachers, [:certificate] => :environment do |_t, args|
  raise 'Argument must be primary_certificate or secondary_certificate' unless %w[primary_certificate secondary_certificate].include? args[:certificate]

  programme = Programme.send(args[:certificate])

  enrolments = UserProgrammeEnrolment.where(programme: programme).in_state(:enrolled).order(:created_at)

  num_users = 0

  puts 'stem_user_id,email'

  enrolments.find_each do |enrolment|
    next unless programme.user_meets_completion_requirement?(enrolment.user)

    num_users += 1
    puts "\"#{enrolment.user.stem_user_id}\",\"#{enrolment.user.email}\""
  end

  puts "Identified #{num_users} users."
  puts 'END OF OUTPUT'
end
