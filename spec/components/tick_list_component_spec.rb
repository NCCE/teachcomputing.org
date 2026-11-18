require "rails_helper"
require "faker"

RSpec.describe TickListComponent, type: :component do
  context "with a tick_list provided" do
    let(:tick_list) do
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
          button_url: Faker::Internet.url(scheme: "https"),
          tracking_page: Faker::Lorem.unique.word,
          tracking_label: Faker::Lorem.unique.word
        }
      }
    end

    before do
      render_inline(described_class.new(tick_list:))
    end

    it "adds the wrapper class" do
      expect(page).to have_css(".#{tick_list[:class_name]}")
    end

    it "renders a title" do
      expect(page).to have_css(
        ".tick-list-component__title",
        text: tick_list[:title]
      )
    end

    it "renders the body text" do
      expect(page).to have_css(
        ".tick-list-component__text",
        text: tick_list[:text]
      )
    end

    it "renders a button" do
      expect(page).to have_link(
        tick_list[:button][:button_title],
        href: tick_list[:button][:button_url]
      )
    end

    it "renders a list with the expected number of items" do
      expect(page).to have_css(
        ".tick-list-component__list li",
        count: tick_list[:bullets].count
      )
    end

    it "adds the GA tag" do
      expect(page).to have_selector("a[href='#{tick_list[:button][:button_url]}'][data-event-action='click']")
      expect(page).to have_selector("a[href='#{tick_list[:button][:button_url]}'][data-event-category='#{tick_list[:button][:tracking_page]}']")
      expect(page).to have_selector("a[href='#{tick_list[:button][:button_url]}'][data-event-label='#{tick_list[:button][:tracking_label]}']")
    end
  end

  context "without a tick-list provided" do
    it "raises an exception" do
      expect { described_class.new(tick_list: nil) }.to raise_error(ArgumentError)
    end
  end
end
