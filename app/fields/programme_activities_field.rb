require "administrate/field/base"

class ProgrammeActivitiesField < Administrate::Field::Base

  def name
    'In Programmes'
  end

  def to_s
    "#{data.map{ _1.programme.title }.join(", ")}"
  end

  def assigned_programmes
    data.map{ _1.programme }
  end

  def available_programmes
    Programme.all.filter{ not assigned_programmes.include?(_1) }
  end

  def programme_select_options
    available_programmes.map { [ _1.title, _1.id, "data-groups": _1.programme_activity_groupings.map{|x| [x.title, x.id ] }.to_json] }
  end

  def self.permitted_attribute(attr, _options = {})
    { "#{attr.to_s}_attributes".to_sym => {} }
  end

end
