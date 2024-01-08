require "administrate/field/base"

class ProgrammeActivitiesField < Administrate::Field::Base

  def assigned_programmes
    data.map{ _1.programme }
  end

  def assigned_programmes_with_groupings
    data.group_by(&:programme).map do |programme, activities|
      [ programme, activities.collect(&:programme_activity_grouping).compact ]
    end
  end

  def name
    'In Programmes'
  end

  def to_s
    "#{data.map{ _1.programme.title }.join(", ")}"
  end

  def available_programmes
    Programme.all
  end
end
