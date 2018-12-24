class UserDetail < ApplicationRecord
  validates :stem_user_id, uniqueness: true
end
