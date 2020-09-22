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

        CurriculumClient::Request.run(client.parse(all), client, "#{context}--all")
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

        CurriculumClient::Request.run(client.parse(one), client, { "#{key}": value }, "#{context}--#{value}")
      end
    end
  end
end
