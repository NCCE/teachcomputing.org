module CurriculumClient
  module Queries
    module RateableQuery
<<<<<<< HEAD
      def rate(context, fields, polarity, id, achiever_contact_number)
        fields = fields ? "{#{fields}}" : ''
        rating = <<~GRAPHQL
          mutation {
            add#{polarity.to_s.classify}#{context.to_s.classify}Rating(
=======
      def rate(fields, id, achiever_contact_number, rating_type)
        fields = fields ? "{#{fields}}" : ''
        rating = <<~GRAPHQL
          mutation {
            #{rating_type.camelcase(:lower)}(
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
              id: "#{id}"
              userStemAchieverContactNo: "#{achiever_contact_number}"
            )
            #{fields}
          }
        GRAPHQL

        CurriculumClient::Request.run(query: client.parse(rating), client: client)
      end

      def add_positive_rating(id:, fields: nil, stem_achiever_contact_no:)
<<<<<<< HEAD
        rate(self::CONTEXT, fields, :positive, id, stem_achiever_contact_no)
      end

      def add_negative_rating(id:, fields: nil, stem_achiever_contact_no:)
        rate(self::CONTEXT, fields, :negative, id, stem_achiever_contact_no)
=======
        rating_type = rating_type(:positive)
        response = rate(fields, id, stem_achiever_contact_no, rating_type)
        response&.send(rating_type)
      end

      def add_negative_rating(id:, fields: nil, stem_achiever_contact_no:)
        rating_type = rating_type(:negative)
        response = rate(fields, id, stem_achiever_contact_no, rating_type)
        response&.send(rating_type)
      end

      def rating_type(polarity)
        "add_#{polarity}_#{self::CONTEXT}_rating"
      end

      def comment(id:, fields: nil, comment:)
        fields = fields ? "{#{fields}}" : ''
        update = <<~GRAPHQL
          mutation {
            updateRating(
              id: "#{id}"
              comment: "#{comment}"
            )
            #{fields}
          }
        GRAPHQL

        CurriculumClient::Request.run(query: client.parse(update), client: client)
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
      end
    end
  end
end
