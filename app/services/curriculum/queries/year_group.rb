module Curriculum
  module Queries
    class YearGroup
      FIELDS = %w[id keyStage yearNumber description units].freeze

      ALL = <<~GRAPHQL.freeze
        query {
          yearGroups {
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      ONE = <<~GRAPHQL.freeze
        query($id: ID!) {
          yearGroup(id: $id) {
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      def self.all
        Curriculum::Request.run(ALL)
      end

      def self.one(id)
        Curriculum::Request.run(ONE, { id: id })
      end
    end
  end
end
