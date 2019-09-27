module Programmes
  class CSAccelerator < Programme

    def user_completed?(user)
      user.achievements
          .for_programme(self)
          .in_state('complete')
          .joins(:activity)
          .where(activities: { category: 'assessment' }).any?
    end
  end
end
