require "rails_helper"

RSpec.describe Programmes::SecondaryCertificate do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: cs_accelerator.id) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 3, :with_activities, programme: secondary_certificate) }

  describe "#pending_delay" do
    it "should return 7 days" do
      expect(secondary_certificate.pending_delay).to eq 7.days
    end
  end

  describe "#user_meets_completion_requirement?" do
    before do
      user
      cs_accelerator
      programme_activity_groupings
    end

    context "when the user has not completed one activity from each group" do
      it "returns false" do
        expect(secondary_certificate.user_meets_completion_requirement?(user)).to eq false
      end
    end

    context "when the user hasn't completed CSA" do
      context "when the user has completed one activity from each group" do
        it "returns false" do
          programme_activity_groupings.each do |group|
            create(:achievement, user_id: user.id, activity_id: group.programme_activities.first.activity.id).transition_to(:complete)
          end

          expect(secondary_certificate.user_meets_completion_requirement?(user)).to eq false
        end
      end
    end

    context "when the user has completed CSA" do
      context "when the user has completed one activity from each group" do
        it "returns true" do
          cs_accelerator_enrolment.transition_to :complete

          programme_activity_groupings.each do |group|
            create(:achievement, user_id: user.id, activity_id: group.programme_activities.first.activity.id).transition_to(:complete)
          end

          expect(secondary_certificate.user_meets_completion_requirement?(user)).to eq true
        end
      end
    end
  end

  describe "#path" do
    it "returns the path for the programme" do
      expect(secondary_certificate.path)
        .to eq("/certificate/secondary-certificate")
    end
  end

  describe "#programme_title" do
    it "returns correct title" do
      expect(secondary_certificate.programme_title)
        .to eq("Teach Secondary Computing")
    end
  end

  describe "#public_path" do
    it "should return public path" do
      expect(secondary_certificate.public_path).to eq "/secondary-certificate"
    end
  end

  describe "#pathways?" do
    it "should return true" do
      expect(secondary_certificate.pathways?).to be true
    end
  end

  describe "#short_name" do
    it "should return its short name" do
      expect(secondary_certificate.short_name).to eq "Secondary certificate"
    end
  end

  describe "#enrol_path" do
    it "returns the path for the enrol" do
      expect(secondary_certificate.enrol_path(user_programme_enrolment: {user_id: "user_id",
                                                                         programme_id: "programme_id"})).to eq("/certificate/secondary-certificate/enrol?user_programme_enrolment%5Bprogramme_id%5D=programme_id&user_programme_enrolment%5Buser_id%5D=user_id")
    end
  end

  describe "#programme_objectives" do
    it "returns one PO::PCR and any PAGs" do
      pags = create_list(:programme_activity_grouping, 3, programme: secondary_certificate)

      pags.each_with_index do |pag, index|
        pag.update(sort_key: index + 1)
      end

      expect(secondary_certificate.programme_objectives.first).to be_a ProgrammeObjectives::ProgrammeCompletionRequired
      expect(secondary_certificate.programme_objectives[1..]).to eq pags
    end
  end
end
