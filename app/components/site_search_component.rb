class SiteSearchComponent < ViewComponent::Base
  attr_reader :default

  def initialize(default: '')
    @default = default
  end
end
