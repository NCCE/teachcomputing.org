require "rails_helper"

RSpec.describe Programme, type: :model do
  let(:generic_programme) { create(:programme) }
  let(:programme) { create(:cs_accelerator) }
  let(:programmes) { create_list(:programme, 3) }
  let(:diagnostic) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:primary_programme) { create(:primary_certificate) }
  let(:secondary_programme) { create(:secondary_certificate) }
  let(:i_belong_programme) { create(:i_belong) }
  let(:a_level) { create(:a_level) }
  let(:non_enrollable_programme) { create(:programme, enrollable: false) }
  let(:user) { create(:user) }
  let(:cpd_badge) { create(:badge, :active, programme_id: programme.id) }
  let(:completion_badge) { create(:badge, :completion, :active, programme_id: programme.id) }

  let(:user_programme_enrolment) { create(:user_programme_enrolment, user_id: user.id, programme_id: programme.id) }
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  describe "associations" do
    it { is_expected.to have_many(:badges) }
    it { is_expected.to have_many(:pathways) }
    it { is_expected.to have_many(:activities).through(:programme_activities) }
    it { is_expected.to have_many(:users).through(:user_programme_enrolments) }
    it { is_expected.to have_many(:programme_activity_groupings) }
    it { is_expected.to have_one(:assessment) }
    it { is_expected.to have_one(:programme_complete_counter) }
    it { is_expected.to have_many(:questionnaires) }
  end

  describe "scopes" do
    describe "#enrollable" do
      before do
        programmes
        non_enrollable_programme
      end

      it "contains only programmes that are enrollable" do
        expect(described_class.enrollable).to match_array(programmes)
        expect(described_class.enrollable).not_to include non_enrollable_programme
      end
    end
  end

  describe "#include_in_filter?" do
    it "should return true" do
      expect(generic_programme.include_in_filter?).to be true
    end
  end

  describe "#pending_delay" do
    it "should raise NotImplementedError" do
      expect(generic_programme.pending_delay).to be nil
    end
  end

  describe "#user_enrolled?" do
    it "returns true if user is enrolled on the programme" do
      user_programme_enrolment
      expect(programme.user_enrolled?(user)).to be(true)
    end

    it "returns false if user is not enrolled on the programme" do
      expect(programme.user_enrolled?(user)).to be(false)
    end

    it "returns false if user not defined" do
      expect(programme.user_enrolled?(nil)).to be(false)
    end

    it "returns false if user unenrolled" do
      user_programme_enrolment.transition_to(:unenrolled)
      expect(programme.user_enrolled?(user)).to be(false)
    end
  end

  describe "#cs_accelerator" do
    before do
      programme
    end

    it "returns the subject-knowledge record" do
      expect(described_class.cs_accelerator).to eq programme
    end
  end

  describe "#primary_certificate" do
    before do
      primary_programme
    end

    it "returns the primary record" do
      expect(described_class.primary_certificate).to eq primary_programme
    end

    it "returns the correct type" do
      expect(described_class.primary_certificate).to be_a(Programmes::PrimaryCertificate)
    end
  end

  describe "#secondary_certificate" do
    before do
      secondary_programme
    end

    it "returns the secondary record" do
      expect(described_class.secondary_certificate).to eq secondary_programme
    end

    it "returns the correct type" do
      expect(described_class.secondary_certificate).to be_a(Programmes::SecondaryCertificate)
    end
  end

  describe "#i_belong" do
    before do
      i_belong_programme
    end

    it "returns the i belong record" do
      expect(described_class.i_belong).to eq i_belong_programme
    end

    it "returns the correct type" do
      expect(described_class.i_belong).to be_a(Programmes::IBelong)
    end
  end

  describe "#a_level" do
    before do
      a_level
    end

    it "returns the a level record" do
      expect(described_class.a_level).to eq a_level
    end

    it "returns the correct type" do
      expect(described_class.a_level).to be_a(Programmes::ALevel)
    end
  end

  describe "#cpd_badge" do
    before do
      programme
    end

    context "with a programme but without a badge" do
      it "returns false" do
        expect(programme.cpd_badge).to be nil
      end
    end

    context "with a programme that has a badge" do
      it "returns true when active" do
        cpd_badge
        expect(programme.cpd_badge).to eq cpd_badge
      end

      it "returns false when active is false" do
        cpd_badge.update(active: false)
        expect(programme.cpd_badge).to be nil
      end
    end
  end

  describe "#completion_badge" do
    before do
      programme
    end

    context "with a programme but without a badge" do
      it "returns false" do
        expect(programme.completion_badge).to be nil
      end
    end

    context "with a programme that has a badge" do
      it "returns true when active" do
        completion_badge
        expect(programme.completion_badge).to eq completion_badge
      end

      it "returns false when active is false" do
        completion_badge.update(active: false)
        expect(programme.completion_badge).to be nil
      end
    end
  end

  describe "#user_completed?" do
    context "when the user is enrolled" do
      it "returns false" do
        user_programme_enrolment
        expect(programme.user_completed?(user)).to be false
      end
    end

    context "when the user is pending" do
      it "returns false" do
        user_programme_enrolment.transition_to(:pending)
        expect(programme.user_completed?(user)).to be false
      end
    end

    context "when the user is complete" do
      it "returns true" do
        allow_any_instance_of(Programmes::CSAccelerator).to receive(:user_meets_completion_requirement?).with(user).and_return(true)
        user_programme_enrolment.transition_to(:complete)
        expect(programme.user_completed?(user)).to be true
      end
    end
  end

  describe "#enough_activities_for_test?" do
    it "returns 0" do
      expect(programmes[0].enough_activities_for_test?(user)).to be false
    end
  end

  describe "#primary_certificate?" do
    context "when programme is primary certificate" do
      it "returns true" do
        programme = build(:primary_certificate)
        expect(programme.primary_certificate?).to be(true)
      end
    end

    context "when programme is not primary certificate" do
      it "returns false" do
        programme = build(:programme, slug: "random-programme-slug")
        expect(programme.primary_certificate?).to be(false)
      end
    end
  end

  describe "#cs_accelerator?" do
    context "when programme is cs accelerator" do
      it "returns true" do
        programme = build(:cs_accelerator)
        expect(programme.cs_accelerator?).to be(true)
      end
    end

    context "when programme is not cs accelerator" do
      it "returns false" do
        programme = build(:programme, slug: "another-programme")
        expect(programme.cs_accelerator?).to be(false)
      end
    end
  end

  describe "#secondary_certificate?" do
    context "when programme is secondary certificate" do
      it "returns true" do
        programme = build(:secondary_certificate)
        expect(programme.secondary_certificate?).to be(true)
      end
    end

    context "when programme is not secondary certificate" do
      it "returns false" do
        programme = build(:programme, slug: "another-programme")
        expect(programme.secondary_certificate?).to be(false)
      end
    end
  end

  describe "#i_belong?" do
    context "when programme is an i belong certificate" do
      it "returns true" do
        programme = build(:i_belong)
        expect(programme.i_belong?).to be(true)
      end
    end

    context "when programme is not an i belong certificate" do
      it "returns false" do
        programme = build(:programme, slug: "another-programme")
        expect(programme.i_belong?).to be(false)
      end
    end
  end

  describe "#a_level?" do
    context "when programme is an a level certificate" do
      it "returns true" do
        programme = build(:a_level)
        expect(programme.a_level?).to be(true)
      end
    end

    context "when programme is not an a level certificate" do
      it "returns false" do
        programme = build(:programme, slug: "another-programme")
        expect(programme.a_level?).to be(false)
      end
    end
  end

  describe "#pathways_excluding" do
    it "returns the pathways except for the pathway argument in order" do
      programme = create(:programme)
      p1 = create(:pathway, programme: programme, order: 10)
      p2 = create(:pathway, programme: programme)
      p3 = create(:pathway, programme: programme, order: 9)

      expect(programme.pathways_excluding(p2)).to eq([p3, p1])
    end

    it "returns all pathways in order if argument is nil" do
      programme = create(:programme)
      p1 = create(:pathway, programme: programme, order: 3)
      p2 = create(:pathway, programme: programme, order: 1)
      p3 = create(:pathway, programme: programme, order: 2)

      expect(programme.pathways_excluding(nil)).to eq([p2, p3, p1])
    end
  end

  describe "#public_path" do
    it "should return nil" do
      programme = create(:programme)

      expect(programme.public_path).to be nil
    end
  end

  describe "#pathways?" do
    it "should return false" do
      programme = create(:programme)

      expect(programme.pathways?).to be false
    end
  end

  describe "#user_is_eligible?" do
    it "should return true" do
      programme = create(:programme)
      user = create(:user)

      expect(programme.user_is_eligible?(user)).to be true
    end
  end

  describe "#certificate_name" do
    it "should return not implemented error" do
      expect { generic_programme.certificate_name }.to raise_error(NotImplementedError)
    end
  end

  describe "#mailer" do
    it "should return not implemented error" do
      expect { generic_programme.mailer }.to raise_error(NotImplementedError)
    end
  end

  describe "#bcs_logo" do
    it "should return not implemented error" do
      expect { generic_programme.bcs_logo }.to raise_error(NotImplementedError)
    end
  end

  describe "#achivement_type" do
    it "should return not implemented error" do
      expect { generic_programme.achievement_type }.to raise_error(NotImplementedError)
    end
  end

  describe "#user_qualifies_for_credly_cpd_badge?" do
    it "should return true if the user has compelted a f2f achievement" do
      programme = create(:primary_certificate)
      create(:programme_activity_grouping, programme:, required_for_completion: 1)
      activity = create(:activity) # is face to face
      user = create(:user)
      create(:programme_activity, programme:, activity:)

      create(:user_programme_enrolment, user:, programme:)
      create(:completed_achievement, user:, activity:)

      expect(programme.user_qualifies_for_credly_cpd_badge?(user)).to be true
    end

    it "should return false if the user is not enrolled" do
      programme = create(:primary_certificate)
      create(:programme_activity_grouping, programme:, required_for_completion: 1)
      activity = create(:activity) # is face to face
      user = create(:user)
      create(:programme_activity, programme:, activity:)

      create(:completed_achievement, user:, activity:)

      expect(programme.user_qualifies_for_credly_cpd_badge?(user)).to be false
    end

    it "should return false if the compeleted a f2f achievement doesn't belong to the programme" do
      programme = create(:primary_certificate)
      create(:programme_activity_grouping, programme:, required_for_completion: 1)
      activity = create(:activity) # is face to face
      user = create(:user)

      create(:user_programme_enrolment, user:, programme:)
      create(:completed_achievement, user:, activity:)

      expect(programme.user_qualifies_for_credly_cpd_badge?(user)).to be false
    end
  end

  describe "#auto_enrollable?" do
    it "should return false" do
      programme = create(:programme)

      expect(programme.auto_enrollable?).to be false
    end
  end

  describe "#auto_enrollment_ignored_activity_codes" do
    it "should return []" do
      programme = create(:programme)

      expect(programme.auto_enrollment_ignored_activity_codes).to eq []
    end
  end

  describe "#minimum_character_required_community_evidence" do
    it "should default to zero" do
      programme = create(:programme)

      expect(programme.minimum_character_required_community_evidence).to eq(0)
    end
  end

  describe "#enrolment_confirmation_required?" do
    it "should default to false" do
      programme = create(:programme)

      expect(programme.enrolment_confirmation_required?).to eq(false)
    end
  end
end
