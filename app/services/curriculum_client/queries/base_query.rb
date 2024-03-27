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

          CurriculumClient::Request.run(query: client.parse(all), client:, cache_key:)
        end

        def one(context:, fields:, params:, cache_key: nil)
          declared_param_strings = params.map { |k, _v| "$#{k}: #{map_field_type(k)}" }
          param_strings = params.map { |k, _v| "#{k.to_s.camelize(:lower)}: $#{k}" }
          one = <<~GRAPHQL
            query(#{declared_param_strings.join(", ")}) {
              #{context}(#{param_strings.join(", ")}) {
                #{fields}
              }
            }
          GRAPHQL

          CurriculumClient::Request.run(query: client.parse(one), client:, params:, cache_key:)
        end

        def file_fields
          "name file type size created"
        end

        private

        def map_field_type(key)
          case key
          when :id
            "ID"
          else
            "String"
          end
        end
      end
    end
  end
end
