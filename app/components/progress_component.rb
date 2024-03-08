# frozen_string_literal: true

# this component models a linear list of stuff a user has to do. you can go
# forwards and backwards through the steps one at a time.

class ProgressComponent < ViewComponent::Base
  renders_one :counter, "Counter"
  renders_one :back, "Back"
  renders_one :continue, "Continue"
  renders_one :submit, "Submit"
  renders_many :steps, "Step"

  erb_template <<~ERB
    <div class="progress-component" data-controller="progress-component">
      <%= content %>
    </div>
  ERB

  # a sub component we can style or interact with from JS
  class TargetWrapper < ViewComponent::Base
    def target
      self.class.name.demodulize.downcase
    end

    def css_class
      "progress-component__#{target}"
    end

    erb_template <<~ERB
      <div class="<%= css_class %>" data-progress-component-target="<%= target %>">
        <%= content %>
      </div>
    ERB
  end

  class Counter < TargetWrapper; end
  class Step < TargetWrapper; end

  class Back < TargetWrapper
    erb_template <<~ERB
      <button class="<%= css_class %>" data-progress-component-target="<%= target %>" data-action="progress-component#back">
        <%= content %>
      </button>
    ERB
  end

  class Continue < TargetWrapper
    erb_template <<~ERB
      <button class="<%= css_class %>" data-progress-component-target="<%= target %>" data-action="progress-component#continue">
        <%= content %>
      </button>
    ERB
  end

  # doesn't actually submit anything, just fires an event
  class Submit < TargetWrapper
    erb_template <<~ERB
      <button class="<%= css_class %>" data-progress-component-target="<%= target %>" data-action="progress-component#submit">
        <%= content %>
      </button>
    ERB
  end
end
