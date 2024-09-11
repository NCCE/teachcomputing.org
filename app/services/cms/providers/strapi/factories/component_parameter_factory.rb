module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentParameterFactory
          def self.text_with_asides_paramters
            {
              populate: {
                fields: ["textContent"],
                asideSections: {populate: {fields: "slug"}}
              }
            }
          end
        end
      end
    end
  end
end
