module Cms
  module Providers
    module Strapi
      module Mocks
        class StrapiMock
          cattr_accessor :type, :component_key

          def self.inherited(subclass)
            subclass.attribute(:publishedAt) { Faker::Date.backward }
            subclass.attribute(:createdAt) { Faker::Date.backward }
            subclass.attribute(:updatedAt) { Faker::Date.backward }
            @@type = :model
          end

          def self.strapi_component(key)
            @@type = :component
            @@component_key = key
          end

          def self.attribute(strapi_name, &block)
            @attributes ||= []
            @attributes << StrapiAttribute.new(strapi_name, &block)
          end

          def self.generate_raw_data(**values)
            data = {
              id: values[:id] || Faker::Number.number
            }
            if type == :model
              data[:attributes] = generate_data(**values)
            elsif type == :component
              data[:__component] = @@component_key
              data.merge!(generate_data(**values))
            end
            data
          end

          def self.generate_data(**values)
            @attributes.each_with_object({}) do |attribute, obj|
              obj[attribute.strapi_name] = if values.has_key?(attribute.rails_name)
                values[attribute.rails_name]
              else
                attribute.generate_data(values)
              end
            end
          end

          def self.as_model
            if @@type == :component
              Factories::ComponentFactory.process_component(generate_raw_data)
            end
          end
        end

        class StrapiAttribute
          attr_reader :strapi_name, :data_generator

          def initialize(strapi_name, &data_generator)
            @strapi_name = strapi_name
            @data_generator = data_generator
          end

          def rails_name
            @strapi_name.to_s.underscore.to_sym
          end

          def generate_data(inputs)
            data_generator.call
          end
        end
      end
    end
  end
end
