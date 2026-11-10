require "rails_helper"

RSpec.describe AssessmentDetailsComponent, type: :component do
  let(:user) { create(:user, teacher_reference_number: "1234567") }
  let(:assessment) { create(:assessment) }
  let(:leader_confirmation) { false }

  before do
    render_inline(
      described_class.new(
        user:,
        assessment:,
        duration: 60,
        question_count: 40,
        extended_duration: 90,
        conditions_url: "https://example.com/conditions.pdf",
        leader_confirmation:
      )
    )
  end

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
    expect(page).to have_text("You can take the test twice straight away")
  end

  it "tells them to come back after the test" do
    expect(page).to have_text("use the button at the end to come back here")
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

  context "with a notice" do
    before do
      render_inline(
        described_class.new(
          user:,
          assessment:,
          duration: 60,
          question_count: 40,
          extended_duration: 90,
          conditions_url: "https://example.com/conditions.pdf"
        )
      ) { |component| component.with_notice { "You've taken the test once" } }
    end

    it "shows the notice" do
      expect(page).to have_text("You've taken the test once")
    end
  end
end
