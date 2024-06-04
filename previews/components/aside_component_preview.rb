require "faker"

class AsideComponentPreview < ViewComponent::Preview
  def with_button
    render(AsideComponent.new(
      title: Faker::Lorem.sentence(word_count: 2),
      text: Faker::Lorem.sentence(word_count: 30),
      use_button: true,
      link: {
        text: Faker::Lorem.sentence(word_count: 6),
        url: "#"
      }
    ))
  end

  def without_button
    render(AsideComponent.new(
      title: Faker::Lorem.sentence(word_count: 2),
      text: Faker::Lorem.sentence(word_count: 30),
      use_button: false,
      link: {
        text: Faker::Lorem.sentence(word_count: 6),
        url: "#"
      }
    ))
  end
end
