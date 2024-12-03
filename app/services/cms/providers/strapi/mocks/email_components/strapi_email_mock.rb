module Cms
  module Providers
    module Strapi
      module Mocks
        module EmailComponents
          class StrapiEmailMock < StrapiMock
            class << self
              def as_model(**values)
                if @type == :component
                  Factories::EmailComponentFactory.process_component(generate_raw_data(**values))
                end
              end
            end
          end
        end
      end
    end
  end
end
