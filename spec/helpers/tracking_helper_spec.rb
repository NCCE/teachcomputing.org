require "rails_helper"

describe TrackingHelper, type: :helper do
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  let(:request) { ActionController::TestRequest.create({}) }

  let(:lookup) do
    [
      {route: "/curriculum", category: "Curriculum landing"},
      {route: "/about", category: "About"},
      {route: "/gender-balance", category: "GBIC"},
      {route: "/hubs", category: "Hubs"},
      {route: "/impact-and-evaluation", category: "Impact"},
      {route: "/primary-certificate", category: "Primary unenrolled"},
      {route: "/certificate/primary-certificate", category: "Primary enrolled"},
      {route: "/certificate/i-belong", category: "I Belong enrolled"}
    ]
  end

  it "returns the expected category names" do
    lookup.each do |item|
      request.path = item[:route]
      controller.request = request
      allow(helper).to receive(:request).and_return(request)

      expect(tracking_data("test_1")).to eq(
        {event_action: "click", event_category: item[:category], event_label: "test_1"}
      )
    end
  end

  it "returns nil if the category isn't found" do
    request.path = "an_undefined_route"
    controller.request = request
    allow(helper).to receive(:request).and_return(request)

    expect(tracking_data("test_3")).to be_a(Hash)
  end

  it "overrides the category when one is passed" do
    expect(tracking_data("test_2", "test_category")).to eq(
      {event_action: "click", event_category: "test_category", event_label: "test_2"}
    )
  end
end
