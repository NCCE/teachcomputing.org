module CurriculumClient
  module Queries
    module RateableQuery
      def rate(context, fields, polarity, id, achiever_contact_number)
        fields = fields ? "{#{fields}}" : ''
        rating = <<~GRAPHQL
          mutation {
            add#{polarity.to_s.classify}#{context.to_s.classify}Rating(
              id: "#{id}"
              userStemAchieverContactNo: "#{achiever_contact_number}"
            )
            #{fields}
          }
        GRAPHQL

        CurriculumClient::Request.run(client.parse(rating), client)
      end

      def add_positive_rating(id:, fields: nil, stem_achiever_contact_no:)
        rate(self::CONTEXT, fields, :positive, id, stem_achiever_contact_no)
      end

      def add_negative_rating(id:, fields: nil, stem_achiever_contact_no:)
        rate(self::CONTEXT, fields, :negative, id, stem_achiever_contact_no)
      end
    end
  end
end
