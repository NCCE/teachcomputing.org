require "rails_helper"

RSpec.describe("certificates/cs_accelerator/_csa-test") do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let!(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    @csa_dash = CSADash.new(user:)
    @current_user = user
    @programme = programme
  end

  describe "before an assessment has been attempted" do
    before do
      user_programme_assessment = instance_double(UserProgrammeAssessment)
      allow(user_programme_assessment).to receive(:currently_taking_test?).and_return(false)
      allow(user_programme_assessment).to receive(:can_take_test_at).and_return(0)
      allow(user_programme_assessment).to receive(:failed_num_attempts).and_return(0)

      assign(:programme, programme)

      render partial: "csa-test", locals: {user_programme_assessment:}
    end

    it "has a practice section" do
      expect(rendered).to have_link("Take our mock test", href: "https://www.classmarker.com/online-test/start/?quiz=gq36013dee29b07b")
    end

    it "has a test section" do
      expect(rendered).to have_text("Ready to take your test?")
    end

    it "has a TRN input field" do
      expect(rendered).to have_field("user[teacher_reference_number]")
    end

    it "has an accept conditions checkbox" do
      expect(rendered).to have_unchecked_field("assessment_attempt[accepted_conditions]")
    end

    it "has a submit button" do
      expect(rendered).to have_button("commit", disabled: true)
    end
  end

  describe "whilst an assessment is being attempted" do
    it "renders the expected text" do
      user_programme_assessment = instance_double(UserProgrammeAssessment)
      allow(user_programme_assessment).to receive(:currently_taking_test?).and_return(true)

      render partial: "csa-test", locals: {user_programme_assessment:}

      expect(rendered).to have_content("You are currently taking the test. If you have recently failed, please come back in 2 hours.")
    end
  end

  describe "when an assessment attempt has failed" do
    let(:time) { Time.new(2020, 11, 11, 12, 22) }

    before do
      allow(Time).to receive(:now).and_return(time)
    end

    it "renders the expected text" do
      user_programme_assessment = instance_double(UserProgrammeAssessment)

      allow(user_programme_assessment).to receive(:currently_taking_test?).and_return(false)
      allow(user_programme_assessment).to receive(:can_take_test_at).and_return(time + 1.day)
      allow(user_programme_assessment).to receive(:failed_num_attempts).and_return(1)

      render partial: "csa-test", locals: {user_programme_assessment:}

      expect(rendered).to have_content("Your second attempt at the test can be done after 1am on Thursday.")
    end
  end
end
