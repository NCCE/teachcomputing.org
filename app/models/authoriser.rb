class Authoriser < ApplicationRecord
  extend Enumerize

  enumerize :organisation, in: %i[bcs stem rpf], default: false
end
