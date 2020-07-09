module Curriculum
  module Queries
    class Lesson
      FIELDS = ['id', 'unit', 'title', 'description', 'lessonPlan', 'activities', 'slides']

      ALL = <<~GRAPHQL
        query {
          lessons {
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      ONE = <<~GRAPHQL
        query($id: ID!) {
          lesson(id: $id) {
            #{FIELDS.join(' ')}
          }
        }
      GRAPHQL

      def self.all
        Curriculum::Request.run(ALL)
      end

      def self.one(id)
        Curriculum::Request.run(ONE, {id: id})
      end
    end
  end
end
