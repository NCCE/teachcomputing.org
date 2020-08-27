module CurriculumClient
  module Queries
    class Unit < CurriculumClient::Queries::BaseQuery
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
            level
          }
        }
        lessons {
          id
          slug
          description
          zippedContents
          title
          objectives
        }
      GRAPHQL

      def self.all(fields = FIELDS)
        super(:units, fields)
      end

      def self.one(slug, fields = FIELDS)
        super(:unit, fields, :slug, slug)
      end

      def self.add_positive_rating(id:, fields: nil, stem_achiever_contact_no:)
        rate(:unit, fields, :positive, id, stem_achiever_contact_no)
      end

      def self.add_negative_rating(id:, fields: nil, stem_achiever_contact_no:)
        rate(:unit, fields, :negative, id, stem_achiever_contact_no)
      end
    end
  end
end
