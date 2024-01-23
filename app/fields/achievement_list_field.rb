require "administrate/field/base"

class AchievementListField < Administrate::Field::Base
  def to_s
    data
  end
end
