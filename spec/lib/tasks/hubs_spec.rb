require "rails_helper"

RSpec.describe "rake dev:populate_hub_regions", type: :task do
  it "should create many hub regions" do
    expect {
      task.execute
    }.to change { HubRegion.count }.by 9
  end
end

RSpec.describe "rake dev:populate_hubs", type: :task do
  it "should create many hub regions" do
    Rake::Task["dev:populate_hub_regions"].invoke
    expect {
      task.execute
    }.to change { Hub.count }
  end
end
