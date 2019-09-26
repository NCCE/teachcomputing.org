module Programmes::CSAccelerator

    def self.user_completed?(user, programme)
      user.achievements
          .for_programme(programme)
          .in_state('complete')
          .joins(:activity)
          .where(activities: { category: 'assessment' }).any?
    end
end
