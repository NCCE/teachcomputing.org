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
      allow(user_programme_assessment).to receive(:retry_at).and_return(nil)
      allow(user_programme_assessment).to receive(:in_cool_off?).and_return(false)
      allow(user_programme_assessment).to receive(:failed_num_attempts).and_return(0)
      allow(user_programme_assessment).to receive(:latest_attempt).and_return(nil)

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

    it "has a ready to begin test checkbox" do
      expect(rendered).to have_unchecked_field("ready_to_test")
    end

    it "has a submit button" do
      expect(rendered).to have_button("commit", disabled: true)
    end

    it "does not mention previous attempts" do
      expect(rendered).not_to have_text("without passing")
    end
  end

  describe "whilst an assessment is being attempted" do
    let(:attempt) { create(:assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2020-11-11 14:14")) }
    let(:now) { Time.zone.parse("2020-11-11 14:30") }

    around { |example| travel_to(now) { example.run } }

    before do
      user_programme_assessment = instance_double(UserProgrammeAssessment)
      allow(user_programme_assessment).to receive(:currently_taking_test?).and_return(true)
      allow(user_programme_assessment).to receive(:latest_attempt).and_return(attempt)

      render partial: "csa-test", locals: {user_programme_assessment:}
    end

    context "when the expiry time has passed" do
      let(:now) { Time.zone.parse("2020-11-11 16:30") }

      it "does not show a time that has already passed" do
        expect(rendered).not_to have_text("4:14pm on Wednesday 11 November 2020")
      end

      it "does not show the form" do
        expect(rendered).not_to have_button("commit")
      end
    end

    it "shows when the test was started" do
      expect(rendered).to have_text("2:14pm on Wednesday 11 November 2020")
    end

    it "shows when a new attempt can be started" do
      expect(rendered).to have_text("4:14pm on Wednesday 11 November 2020")
    end

    it "does not show the form" do
      expect(rendered).not_to have_button("commit")
    end

    it "does not ask if they are ready to take the test" do
      expect(rendered).not_to have_text("Ready to take your test?")
    end
  end

  describe "when the latest attempt timed out" do
    let(:attempt) { create(:timed_out_assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2026-10-10 14:14")) }

    before do
      user_programme_assessment = instance_double(UserProgrammeAssessment)
      allow(user_programme_assessment).to receive(:currently_taking_test?).and_return(false)
      allow(user_programme_assessment).to receive(:retry_at).and_return(nil)
      allow(user_programme_assessment).to receive(:in_cool_off?).and_return(false)
      allow(user_programme_assessment).to receive(:failed_num_attempts).and_return(0)
      allow(user_programme_assessment).to receive(:latest_attempt).and_return(attempt)

      assign(:programme, programme)

      render partial: "csa-test", locals: {user_programme_assessment:}
    end

    it "shows the date of the attempt that was not completed" do
      expect(rendered).to have_text("10 October 2026")
    end

    it "links to support" do
      expect(rendered).to have_link("info@teachcomputing.org", href: "mailto:info@teachcomputing.org")
    end

    it "shows the form" do
      expect(rendered).to have_button("commit", disabled: true)
    end
  end

  describe "when the user can retry after failing" do
    let(:failed_num_attempts) { 1 }

    before do
      user_programme_assessment = instance_double(UserProgrammeAssessment)
      allow(user_programme_assessment).to receive(:currently_taking_test?).and_return(false)
      allow(user_programme_assessment).to receive(:retry_at).and_return(nil)
      allow(user_programme_assessment).to receive(:in_cool_off?).and_return(false)
      allow(user_programme_assessment).to receive(:failed_num_attempts).and_return(failed_num_attempts)
      allow(user_programme_assessment).to receive(:latest_attempt).and_return(nil)

      assign(:programme, programme)

      render partial: "csa-test", locals: {user_programme_assessment:}
    end

    it "tells them they can take it again straight away after one fail" do
      expect(rendered).to have_text("take it again straight away")
    end

    context "when they have failed more than once" do
      let(:failed_num_attempts) { 3 }

      it "shows how many times they have taken the test" do
        expect(rendered).to have_text("taken the test 3 times")
        expect(rendered).not_to have_text("take it again straight away")
      end
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
      allow(user_programme_assessment).to receive(:retry_at).and_return(time + 1.day)
      allow(user_programme_assessment).to receive(:in_cool_off?).and_return(true)
      allow(user_programme_assessment).to receive(:failed_num_attempts).and_return(2)

      render partial: "csa-test", locals: {user_programme_assessment:}

      expect(rendered).to have_text("taken the test twice")
      expect(rendered).to have_text("12:22pm on Thursday 12 November 2020")
      expect(rendered).not_to have_text("Ready to take your test?")
    end
  end
end
