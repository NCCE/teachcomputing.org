require 'rails_helper'
require 'faker'

RSpec.describe TickListComponent, type: :component do
  let(:tick_list) do
    {
      class_name: Faker::Lorem.unique.words.join('-'),
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
        button_url: Faker::Internet.url(scheme: 'https')
      }
    }
  end

  before do
    render_inline(described_class.new(tick_list:))
  end

  it 'adds the wrapper class' do
    expect(rendered_component).to have_css(".#{tick_list[:class_name]}")
  end

  it 'renders a title' do
    expect(rendered_component).to have_css(
      '.tick-list-component__title',
      text: tick_list[:title]
    )
  end

  it 'renders the body text' do
    expect(rendered_component).to have_css(
      '.tick-list-component__text',
      text: tick_list[:text]
    )
  end

  it 'renders a button' do
    expect(rendered_component).to have_link(
      tick_list[:button][:button_title],
      href: tick_list[:button][:button_url]
    )
  end

  it 'renders a list with the expected number of items' do
    expect(rendered_component).to have_css(
      '.tick-list-component__list li',
      count: tick_list[:bullets].count
    )
  end
end
