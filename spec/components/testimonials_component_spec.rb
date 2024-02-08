require "rails_helper"

RSpec.describe TestimonialsComponent, type: :component do
  let(:testimonials) do
    Array.new(3) do
      {
        text: Faker::Quote.matz,
        image: "media/images/curriculum/curriculum.png",
        name: Faker::Games::ElderScrolls.name,
        link_target: "/foo",
        bio: "#{Faker::Games::ElderScrolls.race} at #{Faker::Games::ElderScrolls.city}"
      }
    end
  end

  it "renders testimonials" do
    render_inline(described_class.new(testimonials:, event_tracking_category: nil, testimonials_per_row: 3))

    # the correct number of testimonials
    expect(page).to have_selector(".testimonial", count: 3)

    # each testimonial has the information we expect
    testimonials.each do |testimonial|
      expect(page).to have_selector(".testimonial .testimonial__text", text: testimonial[:text])
      expect(page).to have_selector(".testimonial .testimonial__bio a[href='#{testimonial[:link_target]}']", text: testimonial[:name])
      expect(page).to have_selector(".testimonial .testimonial__bio", text: testimonial[:bio])
    end
  end
end
