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
    yearGroup {
      yearNumber
      slug
      keyStage {
        slug
        shortTitle
      }
    }
    lessons {
      id
      slug
      title
    }
  GRAPHQL

  def self.all(fields = FIELDS)
    super(:units, fields)
  end

  def self.one(slug, fields = FIELDS)
    super(:unit, fields, :slug, slug)
  end

  def self.add_positive_rating(id, fields = FIELDS)
    rate(:unit, fields, :positive, id)
  end

  def self.add_negative_rating(id, fields = FIELDS)
    rate(:unit, fields, :negative, id)
  end
end
