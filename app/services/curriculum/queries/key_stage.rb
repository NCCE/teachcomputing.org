class Curriculum::Queries::KeyStage < Curriculum::Queries::BaseQuery
  FIELDS = <<~GRAPHQL.freeze
    id
    title
    slug
    shortTitle
    level
    ages
    description
    yearGroups {
      id
    }
    teacherGuide
    years
  GRAPHQL

  def self.all(fields = FIELDS)
    super('keyStages', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('keyStage', fields, 'slug', slug)
  end
end
