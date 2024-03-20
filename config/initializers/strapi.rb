Cms::Providers::Strapi.configure do |config|
  config.api_key = ENV["STRAPI_API_KEY"]
  config.api_url = ENV["STRAPI_URL"]
  puts config
end
