module Programmes
  class CSAccelerator < Programme
    def credits_achieved_for_certificate(user)
      complete_achievements = user.achievements
                                  .for_programme(self)
                                  .in_state('complete')

      total = 0

      total_face_to_face = complete_achievements.with_category('face-to-face').sum(:credit)
      return 100 if total_face_to_face >= 20

      total = 50 if total_face_to_face >= 10

      total_online = [complete_achievements.with_category('online').sum(:credit), 20].min.to_i
      total += total_online / 20 * 50

      total
    end

    def enough_activites_for_test?(user)
      complete_achievements = user.achievements
                                  .for_programme(self)
                                  .in_state('complete')

      total_face_to_face = complete_achievements.with_category('face-to-face').sum(:credit)
      return true if total_face_to_face >= 20

      total_online = complete_achievements.with_category('online').sum(:credit)
      return true if total_face_to_face >= 10 && total_online >= 20

      false
    end

    def max_credits_for_certificate
      100
    end

    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end
  end
end
