module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class Icon
              def self.as_model
                Factories::BlocksFactory.to_icon(generate_data)
              end

              def self.generate_data
                {
                  iconText: Faker::Lorem.sentence(word_count: 3),
                  iconImage: {data: ImageComponents::Image.generate_raw_data}
                }
              end
            end
          end
        end
      end
    end
  end
end
