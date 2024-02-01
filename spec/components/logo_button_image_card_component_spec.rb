require "rails_helper"
require "faker"

RSpec.describe LogoButtonImageCardComponent, type: :component do
  let(:params) do
    {
      logo: {path: "media/images/logos/isaac-logo.svg", alt: Faker::Lorem.unique.sentence},
      image: {
        path: "media/images/pages/secondary-senior-leaders/teaching.png",
        alt: Faker::Lorem.unique.sentence
      },
      title: Faker::Lorem.unique.sentence,
      text: Faker::Lorem.unique.paragraph,
      button: {
        button_title: Faker::Lorem.unique.sentence,
        button_url: Faker::Internet.url(scheme: "https"),
        tracking_page: Faker::Lorem.unique.word,
        tracking_label: Faker::Lorem.unique.word
      },
      class_name: Faker::Lorem.unique.words.join("-")
    }
  end

  before do
    render_inline(described_class.new(**params))
  end

  it "adds the wrapper class" do
    expect(page).to have_css(".#{params[:class_name]}")
  end

  it "renders a title" do
    expect(page).to have_css(
      ".logo-button-image-card-component__title",
      text: params[:title]
    )
  end

  it "renders the body text" do
    expect(page).to have_css(
      ".logo-button-image-card-component__text",
      text: params[:text]
    )
  end

  it "renders a button" do
    expect(page).to have_link(
      params[:button][:button_title],
      href: params[:button][:button_url]
    )
  end

  it "adds the GA tag" do
    expect(page).to have_selector("a[href='#{params[:button][:button_url]}'][data-event-action='click']")
    expect(page).to have_selector("a[href='#{params[:button][:button_url]}'][data-event-category='#{params[:button][:tracking_page]}']")
    expect(page).to have_selector("a[href='#{params[:button][:button_url]}'][data-event-label='#{params[:button][:tracking_label]}']")
  end
end
