class Curriculum::Queries::YearGroup < Curriculum::Queries::BaseQuery
  FIELDS = <<~GRAPHQL.freeze
    id
    slug
    keyStage
    yearNumber
    description
    units
  GRAPHQL

  def self.all(fields = FIELDS)
    super(:yearGroups, fields)
  end

  def self.one(slug, fields = FIELDS)
    super(:yearGroup, fields, :slug, slug)
  end
end
