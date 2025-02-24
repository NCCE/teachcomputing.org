namespace :strapi do
  task update_graphql_schema: :environment do
    raise "You should not run this in production" if Rails.env.production?

    schema = Cms::Providers::Strapi::GraphqlConnection.dump_schema
    File.write(ENV["STRAPI_TEST_SCHEMA_PATH"], schema)
  end
end
