class Curriculum::Queries::Unit < Curriculum::Queries::BaseQuery
  FIELDS = %w[id title slug description unitGuide summativeAssessments summativeAnswers learningGraphs rubrics lessons].freeze

  def self.all(fields = FIELDS)
    super('units', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('unit', fields, 'slug', slug)
  end
end
