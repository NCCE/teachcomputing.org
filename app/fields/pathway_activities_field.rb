require "administrate/field/base"

class PathwayActivitiesField < Administrate::Field::Base

  def name
    'In Pathways'
  end

  def pathways
    data.map { _1.pathway }
  end

  def programmes
    resource.programmes
  end

  def available_pathways
    resource.programmes.map do |programme|
      [ programme, programme.pathways.not_legacy ]
    end
  end

  def new_pathway_options
    resource.programmes.map do |programme|
      [
        programme.title,
        programme.pathways.not_legacy.map{ [ _1.title, _1.id, 'data-title': _1.title, 'data-programme-title': programme.title ] unless pathways.include?(_1) }.compact
      ]
    end
  end

  def self.permitted_attribute(attr, _options = {})
    { "#{attr.to_s}_attributes".to_sym => {} }
  end

  def to_s
    pathways.map(&:title).join(', ')
  end
end
