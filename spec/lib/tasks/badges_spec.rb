require "rails_helper"

RSpec.describe "rake badges:setup_qa_badges", type: :task do
  let!(:primary) { create(:primary_certificate) }
  let!(:secondary) { create(:secondary_certificate) }
  let!(:subject_knowledge) { create(:cs_accelerator) }
  let!(:i_belong) { create(:i_belong) }
  let!(:a_level) { create(:a_level) }

  context "in production" do
    before do
      allow(Rails).to receive(:env) { "production".inquiry }
    end

    it "should raise exception" do
      expect { task.execute }.to raise_error(RuntimeError)
    end
  end

  context "in non production" do
    it "should create badges" do
      expect {
        task.execute
      }.to change { Badge.count }.by(8)
    end
  end
end
