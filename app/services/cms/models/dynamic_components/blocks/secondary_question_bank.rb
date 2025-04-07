module Cms
  module Models
    module DynamicComponents
      module Blocks
        class SecondaryQuestionBank
          attr_accessor :title

          def initialize(title:)
            @title = title
          end

          def render
            Cms::SecondaryQuestionBankComponent.new(title:)
          end
        end
      end
    end
  end
end
