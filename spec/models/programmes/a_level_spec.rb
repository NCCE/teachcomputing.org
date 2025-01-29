require "rails_helper"

RSpec.describe Programmes::ALevel do
  subject { create(:a_level) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: subject.id) }
  let!(:assessment) { create(:assessment, programme: subject) }

  describe "#mailer" do
    it "returns the ALevelMailer" do
      expect(subject.mailer).to eq(ALevelMailer)
    end
  end

  describe "#path" do
    it "returns the path for the programme" do
      expect(subject.path).to eq("/certificate/a-level-certificate")
    end
  end

  describe "#include_in_filter?" do
    it "should return false" do
      expect(subject.include_in_filter?).to be false
    end
  end

  describe "#enrolment_confirmation_required?" do
    it "should return false" do
      expect(subject.enrolment_confirmation_required?).to be false
    end
  end

  describe "#enrol_path" do
    it "returns the path for the enrol" do
      expect(subject.enrol_path(user_programme_enrolment: {user_id: "user_id",
                                                           programme_id: "programme_id"})).to eq("/certificate/a-level-certificate/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id")
    end
  end

  describe "#programme_title" do
    it "returns correct title" do
      expect(subject.programme_title)
        .to eq("A level subject knowledge")
    end
  end

  describe "#certificate_name" do
    it "should return its certificate name" do
      expect(subject.certificate_name).to eq "A Level subject knowledge certificate"
    end
  end

  describe "#programme_objectives" do
    it "should return a AssessmentPassRequired followed by PAGs" do
      pags = create_list(:programme_activity_grouping, 2, programme: subject)

      expect(subject.programme_objectives.first).to be_a ProgrammeObjectives::AssessmentPassRequired
      expect(subject.programme_objectives[1..]).to match_array(pags)
    end
  end

  describe "#certificate_path" do
    it "should return its certificate path" do
      expect(subject.certificate_path).to eq "/certificate/a-level-certificate/view-certificate"
    end
  end
end
