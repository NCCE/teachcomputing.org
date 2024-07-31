require "administrate/field/base"

class GroupedActivityListField < Administrate::Field::Base
  def grouped_by_category
    Activity.all.group_by(&:category).each_with_object([]) do |(cat, acts), arr|
      arr << [cat, acts.map { [_1.title, _1.id] }]
    end
  end

  def self.permitted_attribute(attr, _options = {})
    :activity_id
  end
end
