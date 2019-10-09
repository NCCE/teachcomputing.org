module Programmes
  class SecondaryCertificate < Programme

    def diagnostic
      false
    end

    def user_completed?(user)
      false
    end

    def user_completed_diagnostic?(user)
      true
    end
  end
end
