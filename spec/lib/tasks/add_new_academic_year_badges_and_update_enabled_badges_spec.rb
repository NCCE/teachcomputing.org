require "rails_helper"

RSpec.describe "add_new_academic_year_badges_and_update_enabled_badges", type: :task do
    let!(:primary_certificate) { create(:primary_certificate)}
    let!(:secondary_certificate) { create(:secondary_certificate)}
    let!(:cs_accelerator) { create(:cs_accelerator)}

    let!(:primary_certificate_badge) { create(:badge, :active, programme_id: primary_certificate.id)}
    let!(:secondary_certificate_badge) { create(:badge, :active, programme_id: secondary_certificate.id)}
    let!(:cs_accelerator_badge) { create(:badge, :active, programme_id: cs_accelerator.id)}

	it "adds new academic year to badges" do 
		allow(Rails.logger).to receive(:warn).at_least(:once)
		task.execute
		expect(Rails.logger).to have_received(:warn).with('Updated with new academic badge years')
        expect(primary_certificate.badges.active.first.academic_year).to eq('2022-23')
        expect(secondary_certificate.badges.active.first.academic_year).to eq('2022-23')
        expect(cs_accelerator.badges.active.first.academic_year).to eq('2022-23')
	end 
end 