class Curriculum::Queries::Lesson < Curriculum::Queries::BaseQuery
  FIELDS = %w[id unit title slug description objectives zippedContents].freeze

  def self.all(fields = FIELDS)
    super('lessons', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('lesson', fields, 'slug', slug)
  end
end
