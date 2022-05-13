module Programmes
  class PrimaryCertificate < Programme
    PROGRAMME_TITLE = 'Primary Computing Teaching'.freeze

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

    def path
      primary_certificate_path
    end

    def enrol_path(opts = {})
      enrol_primary_certificate_path(opts)
    end

    def programme_title
      PROGRAMME_TITLE
    end
  end
end
