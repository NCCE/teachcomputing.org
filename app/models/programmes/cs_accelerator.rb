module Programmes
  class CSAccelerator < Programme

    def diagnostic
      activities.find_by!(category: 'diagnostic')
    end
  end
end
