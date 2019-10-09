module Programmes
  class CSAccelerator < Programme

    def diagnostic
      Activity.find_by!(slug: 'cs-accelerator-diagnostic-tool')
    end

    def user_completed?(user)
      user.achievements
          .for_programme(self)
          .in_state('complete')
          .joins(:activity)
          .where(activities: { category: 'assessment' }).any?
    end

    def user_completed_diagnostic?(user)
      user.achievements.in_state(:complete).where(activity_id: Programmes::CSAccelerator.diagnostic.id).exists?
    end
  end
end
