require "rails_helper"

RSpec.describe Programmes::IBelong do
  let(:programme) { create(:i_belong) }

  describe "#path" do
    it "returns the path for the programme" do
      expect(programme.path).to eq("/certificate/i-belong")
    end
  end

  describe "#include_in_filter?" do
    it "should return false" do
      expect(programme.include_in_filter?).to be false
    end
  end

  describe "#pending_delay" do
    it "should return 14 days" do
      expect(programme.pending_delay).to eq 14.days
    end
  end

  describe "#enrol_path" do
    it "returns the path for the enrol" do
      expect(programme.enrol_path(user_programme_enrolment: {user_id: "user_id",
                                                             programme_id: "programme_id"})).to eq("/certificate/i-belong/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id")
    end
  end

  describe "#programme_title" do
    it "returns correct title" do
      expect(programme.programme_title)
        .to eq("I Belong: encouraging girls into computer science")
    end
  end

  describe "#certificate_name" do
    it "should return its certificate name" do
      expect(programme.certificate_name).to eq "I Belong"
    end
  end

  describe "#auto_enrollable?" do
    it "should return false" do
      expect(programme.auto_enrollable?).to be true
    end
  end

  describe "#auto_enrollment_ignored_activity_codes" do
    it "should return [\"FD022\", \"CP409\"]" do
      expect(programme.auto_enrollment_ignored_activity_codes).to eq ["FD022", "CP409"]
    end
  end

  describe "#minimum_character_required_community_evidence" do
    it "should return 50" do
      expect(programme.minimum_character_required_community_evidence).to eq(50)
    end
  end
end
