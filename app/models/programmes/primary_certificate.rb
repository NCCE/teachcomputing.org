module Programmes
  class PrimaryCertificate < Programme
    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end

    def diagnostic_result(user)
      questionnaire = Questionnaire.find_by(slug: 'primary-certificate-enrolment-questionnaire')
      response = QuestionnaireResponse.find_by(user: user, questionnaire: questionnaire)

      response.answers.keys.reduce(0) { |score, key| score + response.answers[key].to_i }
    end

    def credits_achieved_for_certificate(user)
      complete_achievements = user.achievements
                                  .for_programme(self)
                                  .in_state('complete')

      total = 0

      total += 20 if complete_achievements.with_category('online').any?
      total += 20 if complete_achievements.with_category('face-to-face').any?
      total += 5 if complete_achievements.with_category('community').with_credit('5').any?
      total += 10 if complete_achievements.with_category('community').with_credit('10').any?
      total += 20 if complete_achievements.with_category('community').with_credit('20').any?

      total
    end

    def max_credits_for_certificate
      75
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
