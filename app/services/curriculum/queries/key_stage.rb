class Curriculum::Queries::KeyStage < Curriculum::Queries::BaseQuery
  FIELDS = %w[id title slug shortTitle level ages description yearGroups teacherGuide years].freeze

  def self.all(fields = FIELDS)
    super('keyStages', fields)
  end

  def self.one(slug, fields = FIELDS)
    super('keyStage', fields, 'slug', slug)
  end
end
