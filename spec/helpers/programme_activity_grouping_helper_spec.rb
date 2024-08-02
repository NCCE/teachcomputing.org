require "rails_helper"

RSpec.describe ProgrammeActivityGroupingHelper do
  describe "#primary_completion_instruction" do
    context "when web_copy_completion_instruction is present" do
      let(:web_copy_completion_instruction) { "enable you to develop your teaching expertise" }
      let(:group) { create(:programme_activity_grouping, web_copy_completion_instruction:) }

      it "should return the correct instruction string" do
        expect(helper.primary_completion_instruction(group)).to eq(
          "<strong>Choose at least one activity</strong> to enable you to develop your teaching expertise"
        )
      end
    end

    context "when only title is present" do
      let(:title) { "Develop your teaching practice" }
      let(:group) { create(:programme_activity_grouping, title:) }

      it "should return the correct instruction string" do
        expect(helper.primary_completion_instruction(group)).to eq(
          "<strong>Choose at least one activity</strong> to develop your teaching practice"
        )
      end
    end
  end

  describe "#i_belong_completion_instruction" do
    let(:required_for_completion) { 1 }
    let(:title) { "Encourage girls into computer science" }
    let(:group) { create(:programme_activity_grouping, required_for_completion:, title:) }
    let!(:programme_activities) { create_list(:programme_activity, 3, programme_activity_grouping: group) }

    context "when the count for required for completion is not equal to the quantity of activities" do
      context "when the count required for completion is one" do
        it "should state the quantity required for completion with correct singlars" do
          expect(helper.i_belong_completion_instruction(group)).to end_with "by completing <strong>at least one</strong> activity"
        end
      end

      context "when the count required for completion is two" do
        let(:required_for_completion) { 2 }

        it "should state the quantity required for completion with correct plurals" do
          expect(helper.i_belong_completion_instruction(group)).to end_with "by completing <strong>at least two</strong> activities"
        end
      end
    end

    context "when the count for required for completion is equal to the quantity of activities" do
      let(:required_for_completion) { 3 }

      it "shouldn't state how many are required for completion" do
        expect(helper.i_belong_completion_instruction(group)).to eq "Encourage girls into computer science"
      end
    end

    context "when the count for required completion is not equal to the quantity of non-coming-soon activities" do
      it "should state the quantity required for completion with correct singlars" do
        programme_activities.last.activity.update(coming_soon: true)

        expect(helper.i_belong_completion_instruction(group)).to end_with "by completing <strong>at least one</strong> activity"
      end
    end

    context "when the count for required completion is equal to the quantity of non-coming-soon activities" do
      let(:required_for_completion) { 2 }

      it "should state the quantity required for completion with correct singlars" do
        programme_activities.last.activity.update(coming_soon: true)

        expect(helper.i_belong_completion_instruction(group)).to end_with "Encourage girls into computer science"
      end
    end
  end
end
