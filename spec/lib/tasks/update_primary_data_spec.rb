require "rails_helper"

RSpec.describe "update_primary_data", type: :task do

	it "updates certificate activity data" do 
    Rails.application.load_seed
    allow(Rails.logger).to receive(:warn).at_least(:once)
    task.execute
		expect(Rails.logger).to have_received(:warn).with('Updating primary certificate data')
	end 
end 