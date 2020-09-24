module CurriculumClient
  module Queries
    class BaseQuery
      class << self
        def client
          @client ||= CurriculumClient::Connection.connect
        end

        def all(context:, fields:, cache_key:)
          all = <<~GRAPHQL
            query {
              #{context} {
                #{fields}
              }
            }
          GRAPHQL

          CurriculumClient::Request.run(query: client.parse(all), client: client, cache_key: cache_key)
        end

        def one(context:, fields:, key:, value:, cache_key:)
          one = <<~GRAPHQL
            query($#{key}: #{map_field_type(key)}) {
              #{context}(#{key}: $#{key}) {
                #{fields}
              }
            }
          GRAPHQL

          CurriculumClient::Request.run(query: client.parse(one), client: client, params: { "#{key}": value }, cache_key: cache_key)
        end

        private

          def map_field_type(key)
            case key
            when :id
              'ID'
            when :slug
              'String'
            else
              raise CurriculumClient::Errors::UnsupportedType "No type defined for: #{key}"
            end
          end
      end
    end
  end
end
