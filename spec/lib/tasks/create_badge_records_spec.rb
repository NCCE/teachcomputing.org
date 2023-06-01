require "rails_helper"

RSpec.describe "create_badge_records", type: :task do
	it "creates badge records" do 
        FactoryBot.create(:primary_certificate)
        FactoryBot.create(:cs_accelerator)
        badge_count = Badge.count
		allow(Rails.logger).to receive(:warn).at_least(:once)
		task.execute
		expect(Rails.logger).to have_received(:warn).with('Creating badge records')
        expect(Badge.count).to eq(4)
	end 
end 