require "faker"

class BursaryComponentPreview < ViewComponent::Preview
  def default
    params = {
      text: Faker::Lorem.sentence(word_count: 16),
      tracking_event_category: Faker::Lorem.unique.word,
      tracking_event_label: Faker::Lorem.unique.word,
      class_name: "bursary-component"
    }
    render(BursaryComponent.new(**params))
  end
end
