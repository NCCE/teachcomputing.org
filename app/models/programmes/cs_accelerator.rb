module Programmes
  class CSAccelerator < Programme

    def credits_achieved_for_certificate(user)
      complete_achievements = user.achievements
                                  .for_programme(self)
                                  .in_state('complete')

      total = 0

      total += [complete_achievements.with_category('online').sum(:credit), 40].min.to_i
      total += [complete_achievements.with_category('face-to-face').sum(:credit), 40].min.to_i

      total
    end

    def enough_activites_for_test?(user)
      complete_achievements = user.achievements
                                  .for_programme(self)
                                  .in_state('complete')

      total = complete_achievements.with_category('face-to-face').sum(:credit)
      return false if total.zero?

      return true if total >= 20

      total += complete_achievements.with_category('online').sum(:credit)
      return true if total >= 20

      false
    end

    def max_credits_for_certificate
      80
    end

    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end
  end
end
