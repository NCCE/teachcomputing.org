class BenchmarkBorderedCardsComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::UrlHelper
  include CareersHelper

  def default
    render(
      BenchmarkBorderedCardsComponent.new(
        cards: careers_support_resource_cards,
        class_name: "bordered-card--careers-support",
        cards_per_row: 3
      )
    )
  end
end
