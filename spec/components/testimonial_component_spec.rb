require "rails_helper"

RSpec.describe TestimonialComponent, type: :component do
  let(:testimonial) do
    {
      text: Faker::Quote.matz,
      image: "media/images/curriculum/curriculum.png",
      name: Faker::Games::ElderScrolls.name,
      link_target: "/foo",
      bio: "#{Faker::Games::ElderScrolls.race} at #{Faker::Games::ElderScrolls.city}"
    }
  end

  it "renders testimonials" do
    render_inline(described_class.new(**testimonial))

    # each testimonial has the information we expect
    expect(page).to have_selector(".testimonial .testimonial__text", text: testimonial[:text])
    expect(page).to have_selector(".testimonial .testimonial__bio a[href='#{testimonial[:link_target]}']", text: testimonial[:name])
    expect(page).to have_selector(".testimonial .testimonial__bio", text: testimonial[:bio])
  end
end
