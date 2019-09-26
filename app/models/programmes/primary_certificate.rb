module Programmes::PrimaryCertificate

  def self.user_completed?(user, programme)
    complete_achievements = user.achievements
                                .for_programme(self)
                                .in_state('complete')

    return complete_achievements.with_category('online')
                                .any?
           && complete_achievements.with_category('face-to-face')
                                   .any?
           && complete_achievements.with_category('community')
                                   .with_credit('5')
                                   .any?
           && complete_achievements.with_category('community')
                                   .with_credit('10')
                                   .any?
           && complete_achievements.with_category('community')
                                   .with_credit('20')
                                   .any?
  end
end
