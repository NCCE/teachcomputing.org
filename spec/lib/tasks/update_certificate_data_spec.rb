require "rails_helper"

RSpec.describe "update_certificate_data", type: :task do
	Rails.application.load_seed

	it "updates certificate activity data" do 
		allow(Rails.logger).to receive(:warn).at_least(:once)
		task.execute
		expect(Rails.logger).to have_received(:warn).with('Updating secondary certificate activity data')
		expect(Rails.logger).to have_received(:warn).with('Updating primary certificate activity data')
		expect(Rails.logger).to have_received(:warn).with('Updating programme activity groupings for primary and secondary certificate')
	end 
end 