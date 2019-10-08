module Programmes
  class PrimaryCertificate < Programme

    def diagnostic
      activity = Activity.find_by!(slug: 'primary-certificate-diagnostic')
    end

    def user_completed?(user)
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

    def user_completed_diagnostic(user)
      user.achievements.in_state(:complete).where(activity_id: self.diagnostic.id).exists?
    end
  end
end
