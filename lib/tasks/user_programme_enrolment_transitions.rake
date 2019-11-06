namespace :user_programme_enrolment_transitions do
  task complete: :environment do
    include ProgrammesHelper

    programme = Programme.cs_accelerator
    assessment_activity = Activity.find_by(slug: 'cs-accelerator-assessment')
    assessment_achievements = Achievement.in_state(:complete).where(activity_id: assessment_activity.id)

    puts "total no: of achievements #{assessment_achievements.count}"
    assessment_achievements.each do |achievement|
      user = User.find(achievement.user_id)
      cert_no = achievement.last_transition.metadata['certificate_number']
      enrolment = user.user_programme_enrolments.find_by(programme_id: programme.id)
      enrolment.transition_to(:complete, certificate_number: cert_no)

      puts "enrolment state now #{enrolment.current_state}, certno: #{enrolment.last_transition.metadata['certificate_number']}"
      enrolment.last_transition.update(created_at: achievement.last_transition.created_at)
      puts "enrolment created at now = #{enrolment.last_transition.created_at}"
    end

    puts "Total number of complete programme enrolments: #{UserProgrammeEnrolment.in_state(:complete).count}"
  end
end
