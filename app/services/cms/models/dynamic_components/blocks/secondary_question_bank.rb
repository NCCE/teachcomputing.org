module Cms
  module Models
    module DynamicComponents
      module Blocks
        class SecondaryQuestionBank
          include ContainsCached

          attr_accessor :title

          def initialize(title:)
            @title = title
          end

          def render
            Cms::SecondaryQuestionBankComponent.new(title:)
          end

          def clear_cache
            Cms::Collections::SecondaryQuestionBankItems.clear_cache
          end
        end
      end
    end
  end
end
