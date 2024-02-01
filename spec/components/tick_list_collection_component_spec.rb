require "rails_helper"
require "faker"

RSpec.describe TickListCollectionComponent, type: :component do
  let(:title) { Faker::Lorem.unique.sentence }
  let(:tick_list_collection) do
    [
      {
        class_name: Faker::Lorem.unique.words.join("-"),
        title: Faker::Lorem.unique.sentence,
        text: Faker::Lorem.unique.paragraph,
        bullets: [
          Faker::Lorem.unique.sentence,
          Faker::Lorem.unique.sentence,
          Faker::Lorem.unique.sentence,
          Faker::Lorem.unique.sentence
        ],
        button: {
          button_title: Faker::Lorem.unique.sentence,
          button_url: Faker::Internet.url(scheme: "https")
        }
      },
      {
        class_name: Faker::Lorem.unique.words.join("-"),
        title: Faker::Lorem.unique.sentence,
        text: Faker::Lorem.unique.paragraph,
        bullets: [
          Faker::Lorem.unique.sentence,
          Faker::Lorem.unique.sentence
        ],
        button: {
          button_title: Faker::Lorem.unique.sentence,
          button_url: Faker::Internet.url(scheme: "https")
        }
      }
    ]
  end

  before do
    render_inline(described_class.new(tick_list_collection:, title:))
  end

  it "renders a collection element" do
    expect(page).to have_css(".tick-list-collection-component", count: 1)
  end

  it "renders an element for each tick list" do
    expect(page).to have_css(".tick-list-component__wrapper", count: 2)
  end
end
