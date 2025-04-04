module Cms
  module Models
    module EmailComponents
      class BaseComponent
        def render?(email_template, user)
          true
        end

        def render(email_template, user)
          raise NotImplementedError
        end

        def render_text(email_template, user)
          raise NotImplementedError
        end
      end
    end
  end
end
