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
    super('lessons', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('lesson', fields, 'slug', slug)
  end
end
