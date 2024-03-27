module CurriculumClient
  module Queries
    module RateableQuery
      def rate(fields, id, achiever_contact_number, rating_type)
        fields = fields ? "{#{fields}}" : ""
        rating = <<~GRAPHQL
          mutation {
            #{rating_type.camelcase(:lower)}(
              id: "#{id}"
              userStemAchieverContactNo: "#{achiever_contact_number}"
            )
            #{fields}
          }
        GRAPHQL

        CurriculumClient::Request.run(query: client.parse(rating), client:)
      end

      def add_positive_rating(id:, stem_achiever_contact_no:, fields: nil)
        rating_type = rating_type(:positive)
        response = rate(fields, id, stem_achiever_contact_no, rating_type)
        response&.send(rating_type)
      end

      def add_negative_rating(id:, stem_achiever_contact_no:, fields: nil)
        rating_type = rating_type(:negative)
        response = rate(fields, id, stem_achiever_contact_no, rating_type)
        response&.send(rating_type)
      end

      def rating_type(polarity)
        "add_#{polarity}_#{self::CONTEXT}_rating"
      end

      def update_rating(id:, key:, value:, fields: nil)
        fields = fields ? "{#{fields}}" : ""
        value = value.is_a?(Array) ? "[\"#{value.join('","')}\"]" : "\"#{value}\""
        update = <<~GRAPHQL
          mutation {
            updateRating(
              id: "#{id}"
              #{key}: #{value}
            )
            #{fields}
          }
        GRAPHQL
        CurriculumClient::Request.run(query: client.parse(update), client:)
      end
    end
  end
end
