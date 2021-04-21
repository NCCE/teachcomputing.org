class CSAcceleratorEligibleCoursesForSecondaryCertificateUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    programme = Programme.secondary_certificate
    additional_csa_course_activity = Activity.find_by(slug: 'complete-a-cs-accelerator-course')
    metadata = {}

    return if user.achievements.for_programme(programme).where(activity_id: additional_csa_course_activity.id).any?

    eligible_courses = programme.csa_eligible_courses(user)

    if eligible_courses.any?
      achievement = Achievement.create(activity_id: additional_csa_course_activity.id, user_id: user.id,
                                       programme_id: programme.id)

      metadata[:self_verification_info] = eligible_courses.map { |achievement| achievement.activity.title }
      achievement.transition_to(:complete, metadata)
      CertificatePendingTransitionJob.set(wait: 1.minute).perform_later(programme, user.id,
                                          source: 'CSAcceleratorEligibleCoursesForSecondaryCertificateUserJob')
    end
  end
end
