module Programmes
  class PrimaryCertificate < Programme

    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end
  end
end
