require "rails_helper"

RSpec.describe AssessmentSectionComponent, type: :component do
  let(:user) { create(:user, teacher_reference_number: "1234567") }
  let(:assessment) { create(:assessment) }
  let(:leader_confirmation) { false }
  let(:currently_taking_test) { false }
  let(:retry_at) { nil }
  let(:failed_num_attempts) { 0 }
  let(:latest_attempt) { nil }

  let(:user_programme_assessment) do
    instance_double(
      UserProgrammeAssessment,
      currently_taking_test?: currently_taking_test,
      in_cool_off?: retry_at.present? && retry_at.future?,
      retry_at:,
      failed_num_attempts:,
      latest_attempt:
    )
  end

  let(:component) do
    described_class.new(
      user:,
      assessment:,
      user_programme_assessment:,
      duration: 60,
      question_count: 40,
      extended_duration: 90,
      conditions_url: "https://example.com/conditions.pdf",
      leader_confirmation:
    )
  end

  before do
    render_inline(component) { |c| c.with_cool_off_advice { "Try some more courses" } }
  end

  context "before any attempts" do
    it "asks if they're ready" do
      expect(page).to have_text("Ready to take your test?")
    end

    it "shows the test length and number of questions" do
      expect(page).to have_text("You'll have 60 minutes to answer 40 multiple-choice questions")
    end

    it "shows the extended test time" do
      expect(page).to have_text("we can extend the test time to 90 minutes")
      expect(page).to have_link("email us", href: "mailto:certificationqueries@bcs.uk")
    end

    it "links to the exam conditions" do
      expect(page).to have_link("full details of exam conditions", href: "https://example.com/conditions.pdf")
      expect(page).to have_link("the full exam conditions", href: "https://example.com/conditions.pdf")
    end

    it "explains the attempt rules" do
      expect(page).to have_text("You can take the test twice straight away. After that, you'll need to wait 48 hours after a failed attempt")
    end

    it "tells them to come back after the test" do
      expect(page).to have_text("use the button at the end to come back here")
    end

    it "does not mention previous attempts" do
      expect(page).not_to have_text("without passing")
    end

    it "does not show the cool-off advice" do
      expect(page).not_to have_text("Try some more courses")
    end

    it "prefills the TRN" do
      expect(page).to have_field("user_teacher_reference_number", with: "1234567")
    end

    it "submits the user and assessment" do
      expect(page).to have_field("assessment_attempt[user_id]", type: :hidden, with: user.id)
      expect(page).to have_field("assessment_attempt[assessment_id]", type: :hidden, with: assessment.id)
    end

    it "disables the button until the conditions are accepted" do
      expect(page).to have_unchecked_field("assessment_attempt_accepted_conditions")
      expect(page).to have_button("Take the test", disabled: true)
    end

    it "does not mention a school leader" do
      expect(page).not_to have_text("Senior Leader")
      expect(page).not_to have_field("ready_to_test")
    end

    context "when leader_confirmation is set" do
      let(:leader_confirmation) { true }

      it "says a school leader will need to confirm the exam conditions" do
        expect(page).to have_text("you'll be required to provide the email address of a Senior Leader or course leader")
      end

      it "asks them to confirm they're ready" do
        expect(page).to have_unchecked_field("ready_to_test")
      end
    end
  end

  context "after one fail" do
    let(:failed_num_attempts) { 1 }

    it "says they can take it again straight away" do
      expect(page).to have_text("You've taken the test once without passing. You can take it again straight away. If you don't pass, you'll need to wait 48 hours", normalize_ws: true)
    end

    it "shows the form" do
      expect(page).to have_button("Take the test", disabled: true)
    end
  end

  context "after the cool-off has ended" do
    let(:failed_num_attempts) { 3 }

    it "says how many times they've taken the test" do
      expect(page).to have_text("You've taken the test 3 times without passing. If you don't pass your next attempt, you'll need to wait 48 hours", normalize_ws: true)
    end

    it "shows the form" do
      expect(page).to have_button("Take the test", disabled: true)
    end
  end

  context "in the cool-off" do
    let(:retry_at) { Time.zone.parse("2026-11-12 14:14") }
    let(:failed_num_attempts) { 2 }

    around { |example| travel_to(Time.zone.parse("2026-11-11 14:14")) { example.run } }

    it "says when they can take it again" do
      expect(page).to have_text("You've taken the test twice without passing. You can take it again after 2:14pm on Thursday 12 November 2026.")
    end

    it "shows the cool-off advice" do
      expect(page).to have_text("Try some more courses")
    end

    it "does not show the test details or form" do
      expect(page).not_to have_text("Ready to take your test?")
      expect(page).not_to have_button("Take the test")
    end
  end

  context "with an attempt in progress" do
    let(:currently_taking_test) { true }
    let(:latest_attempt) { create(:assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2026-11-11 14:14")) }

    around { |example| travel_to(Time.zone.parse("2026-11-11 14:30")) { example.run } }

    it "says when they started" do
      expect(page).to have_text("You started the test at 2:14pm on Wednesday 11 November 2026.")
    end

    it "does not show the test details or form" do
      expect(page).not_to have_text("Ready to take your test?")
      expect(page).not_to have_button("Take the test")
    end
  end

  context "when the latest attempt timed out" do
    let(:latest_attempt) { create(:timed_out_assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2026-10-10 14:14")) }

    it "says the attempt wasn't completed" do
      expect(page).to have_text("Your last attempt on 10 October 2026 wasn't completed.")
    end

    it "shows the form" do
      expect(page).to have_button("Take the test", disabled: true)
    end
  end
end
