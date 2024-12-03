require "administrate/field/base"

class GroupedActivityListField < Administrate::Field::Base
  def grouped_by_category
    Activity.includes([:programmes]).all.group_by(&:category).each_with_object([]) do |(cat, acts), arr|
      arr << [cat, acts.sort_by(&:title).map {
                     [
                       "#{_1.stem_activity_code} #{_1.title} #{_1.remote_delivered_cpd ? "(remote)" : ""} -- (#{_1.programmes.collect(&:slug).join(", ")})",
                       _1.id
                     ]
                   }]
    end
  end

  def self.permitted_attribute(attr, _options = {})
    :activity_id
  end
end
