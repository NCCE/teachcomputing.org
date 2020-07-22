class Curriculum::Queries::Lesson < Curriculum::Queries::BaseQuery
  FIELDS = <<~GRAPHQL.freeze
    id
    unit
    title
    slug
    description
    objectives
    zippedContents
    unit {
      slug
      title
      yearGroup {
        yearNumber
        keyStage {
          shortTitle
          slug
        }
      }
    }
  GRAPHQL

  def self.all(fields = FIELDS)
    super(:lessons, fields)
  end

  def self.one(slug, fields = FIELDS)
    super(:lesson, fields, :slug, slug)
  end

  def self.add_positive_rating(id, fields = FIELDS)
    rate(:lesson, fields, :positive, id)
  end

  def self.add_negative_rating(id, fields = FIELDS)
    rate(:lesson, fields, :negative, id)
  end
end
