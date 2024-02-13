module Cms
  module Providers
    module Strapi
      class Client
        def initialize
          @connection = Connection.api
        end

        def all(collection_key, page, page_size, params)
          params[:pagination] = {
            page:,
            pageSize: page_size
          }
          response = @connection.get(collection_key, params)
          body = JSON.parse(response.body, symbolize_names: true)
          {
            resources: body[:data].map {
              {
                id: _1[:id],
                attributes: _1[:attributes],
                created_at: _1[:attributes][:createdAt],
                updated_at: _1[:attributes][:updatedAt],
                published_at: _1[:attributes][:publishedAt]
              }
            },
            page: body[:meta][:pagination][:page],
            page_size: body[:meta][:pagination][:pageSize],
            page_number: body[:meta][:pagination][:pageCount],
            total_records: body[:meta][:pagination][:total]
          }
        end

        def one(page_key, params)
          response = @connection.get(page_key, params)
          body = JSON.parse(response.body, symbolize_names: true)[:data]
          {
            id: body[:id],
            attributes: body[:attributes],
            created_at: body[:attributes][:createdAt],
            updated_at: body[:attributes][:updatedAt],
            published_at: body[:attributes][:publishedAt]
          }
        end
      end
    end
  end
end
