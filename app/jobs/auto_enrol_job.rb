class AutoEnrolJob < ApplicationJob
  queue_as :default

  def perform(achievement:)
    user = achievement.user

    return if achievement.activity.community?

    achievement.activity.programmes.each do |programme|
      next unless programme.auto_enrollable?
      next if programme.user_enrolled?(user)
      next if achievement.activity.stem_activity_code.in? programme.auto_enrollment_ignored_activity_codes

      # CSA will return false when asked `pathways?`. This is intentional as users will be guided down the special CSA
      # pathway selection flow. This is not the case for other certificates
      pathway =
        if programme.pathways?
          programme.pathways.not_legacy.first
        end

      Programmes::UserEnroller.new(
        programme_id: programme.id,
        pathway_slug: pathway.slug,
        user_id: user.id,
        auto_enrolled: true
      ).call
    end
  end
end
