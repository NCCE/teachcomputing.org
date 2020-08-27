module CurriculumClient
  module Queries
    class BaseQuery
      def self.client
        @client ||= CurriculumClient::Connection.connect
      end

      def self.all(context, fields)
        all = <<~GRAPHQL
          query {
            #{context} {
              #{fields}
            }
          }
        GRAPHQL

        CurriculumClient::Request.run(client.parse(all), client)
      end

      def self.map_field_type(key)
        case key
        when :id
          'ID'
        when :slug
          'String'
        else
          raise CurriculumClient::Errors::UnsupportedType "No type defined for: #{key}"
        end
      end

      def self.one(context, fields, key, value)
        one = <<~GRAPHQL
          query($#{key}: #{map_field_type(key)}) {
            #{context}(#{key}: $#{key}) {
              #{fields}
            }
          }
        GRAPHQL

        CurriculumClient::Request.run(client.parse(one), client, { "#{key}": value })
      end

      def self.rate(context, fields, polarity, id, achiever_contact_number)
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
    end
  end
end
