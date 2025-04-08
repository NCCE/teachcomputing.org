require "rails_helper"

describe CertificateHelper, type: :helper do
  let(:user) { create(:user) }
  let(:programme_activity_grouping) { create(:programme_activity_grouping) }
  let(:other_programme_activity_grouping) { create(:programme_activity_grouping) }

  describe "#add_group_complete_icon_class" do
    it "should return blank if user not completed" do
      allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(false)
      expect(helper.add_group_complete_icon_class(user, programme_activity_grouping)).to be_blank
    end

    it "should return class if user completed" do
      allow_any_instance_of(ProgrammeActivityGrouping).to receive(:user_complete?).and_return(true)
      expect(helper.add_group_complete_icon_class(user, programme_activity_grouping)).to eq("ncce-activity-list__title--complete")
    end
  end

  describe "#add_groups_complete_icon_class" do
    it "should return blank if not all groups are complete" do
      allow(programme_activity_grouping).to receive(:user_complete?).and_return(false)
      allow(other_programme_activity_grouping).to receive(:user_complete?).and_return(true)
      expect(helper.add_groups_complete_icon_class(user, [programme_activity_grouping, other_programme_activity_grouping])).to be_blank
    end

    it "should return class if all groups complete" do
      allow(programme_activity_grouping).to receive(:user_complete?).and_return(true)
      allow(other_programme_activity_grouping).to receive(:user_complete?).and_return(true)
      expect(helper.add_groups_complete_icon_class(user, [programme_activity_grouping, other_programme_activity_grouping])).to eq("ncce-activity-list__title--complete")
    end
  end
end
