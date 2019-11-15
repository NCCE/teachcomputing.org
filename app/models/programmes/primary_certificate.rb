module Programmes
  class PrimaryCertificate < Programme
    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end

    def diagnostic_result(user)
      diagnostic_achievement = user.achievements
                                   .for_programme(self)
                                   .in_state('complete')
                                   .with_category('diagnostic')
                                   .first

      diagnostic_achievement.last_transition.metadata['score']
    end

    def user_meets_completion_requirement?(user)
      complete_achievements = user.achievements
                                  .for_programme(self)
                                  .in_state('complete')

      return complete_achievements.with_category('online')
                                  .any? &&
            complete_achievements.with_category('face-to-face')
                                    .any? &&
            complete_achievements.with_category('community')
                                    .with_credit('5')
                                    .any? &&
            complete_achievements.with_category('community')
                                    .with_credit('10')
                                    .any? &&
            complete_achievements.with_category('community')
                                    .with_credit('20')
                                    .any?
    end
  end
end
