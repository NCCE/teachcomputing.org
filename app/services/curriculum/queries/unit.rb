class Curriculum::Queries::Unit < Curriculum::Queries::BaseQuery
  FIELDS = <<~GRAPHQL.freeze
    id
    title
    slug
    description
    unitGuide
    summativeAssessments
    summativeAnswers
    learningGraphs
    rubrics
    lessons {
      id
      slug
      title
    }
  GRAPHQL

  def self.all(fields = FIELDS)
    super('units', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('unit', fields, 'slug', slug)
  end
end
