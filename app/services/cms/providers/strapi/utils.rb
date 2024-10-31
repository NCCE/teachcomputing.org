module Cms
  module Providers
    module Strapi
      class Utils
        def initialize
          @strapi_api = Rails.application.config.strapi_api_url
          @strapi_api_key = Rails.application.config.strapi_write_api_key
        end

        def copy_simple_to_web_page(slug)
          simple_page = Cms::Collections::SimplePage.get(slug)

          title = simple_page.data_models[0]
          content = simple_page.data_models[1]
          seo = simple_page.data_models[2]
          data = {
            slug: slug,
            pageTitle: {
              title: title.title
            },
            seo: {
              title: seo.title,
              description: seo.description
            },
            pageContent: [
              {
                __component: "blocks.text-with-asides",
                textContent: content.blocks
              }
            ]
          }
          upload_to_strapi(data, "web-pages")
        end

        def upload_to_strapi(data, resource_key)
          slug = data[:slug]
          params = JSON.generate({data:})
          headers = {
            Authorization: "Bearer #{@strapi_api_key}",
            content_type: :json
          }
          begin
            record = JSON.parse(RestClient.get("#{@strapi_api}/#{resource_key}/#{slug}", {
              Authorization: "Bearer #{@strapi_api_key}"
            }).body)
            id = record["data"]["id"]
            RestClient.put("#{@strapi_api}/#{resource_key}/#{id}", params, headers)
          rescue RestClient::NotFound
            RestClient.post("#{@strapi_api}/#{resource_key}", params, headers)
          end
        end
      end
    end
  end
end
