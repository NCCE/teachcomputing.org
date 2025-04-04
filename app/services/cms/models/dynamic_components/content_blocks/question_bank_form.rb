module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class QuestionBankForm
          attr_accessor :form_name, :links

          def initialize(form_name:, links:)
            @form_name = form_name
            @links = links
          end

          def render
            Cms::QuestionBankFormComponent.new(form_name:, links:)
          end
        end
      end
    end
  end
end
