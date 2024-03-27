class BreadcrumbComponent < ViewComponent::Base
  attr_reader :ancestors, :current_page_name

  def initialize(ancestors:, current_page_name:)
    @ancestors = ancestors
    @current_page_name = current_page_name
  end
end
