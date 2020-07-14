class Curriculum::Queries::YearGroup < Curriculum::Queries::BaseQuery
  FIELDS = %w[id slug keyStage yearNumber description units].freeze

  def self.all(fields = FIELDS)
    super('yearGroups', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('yearGroup', fields, 'slug', slug)
  end
end
