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

  describe "#user_qualifies_for_credly_badge" do
    let(:setup_completed_programme) {
      user_programme_enrolment
      create_list(:programme_activity_grouping, 2, :with_activities, programme: subject)
      create(:completed_assessment_attempt, user:, assessment:)
      subject.programme_activity_groupings.each do |pag|
        create(:completed_achievement, user:, activity: pag.activities.first)
      end
    }

    it "should be false if not enrolled" do
      expect(subject.user_qualifies_for_credly_badge?(user)).to be false
    end

    it "should return false if not meeting completion requirements" do
      user_programme_enrolment
      expect(subject.user_qualifies_for_credly_badge?(user)).to be false
    end

    it "should return true when complete" do
      setup_completed_programme
      expect(subject.user_qualifies_for_credly_badge?(user)).to be true
    end
  end
end
