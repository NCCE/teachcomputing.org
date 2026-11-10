require "rails_helper"

RSpec.describe("certificates/a_level/show", type: :view) do
  let(:user) { create(:user) }
  let(:a_level) { create(:a_level) }
  let(:professional_development_groups) { create_list(:programme_activity_grouping, 1, :with_activities, sort_key: 2, programme: a_level) }
  let(:assessment) { create(:assessment, programme: a_level) }
  let(:latest_attempt) { nil }

  before do
    stub_course_templates
    stub_duration_units

    assign(:programme, a_level)
    assign(:assessment, assessment)
    assign(:latest_attempt, latest_attempt)

    assign(:current_user, user)

    assign(:face_to_face_achievements, [])
    assign(:online_achievements, [])

    assign(:professional_development_groups, professional_development_groups)
    assign(:cpd_courses, professional_development_groups.flat_map(&:programme_activities))

    render
  end

  it "has the hero" do
    expect(rendered).to have_css(".hero__heading", text: a_level.title)
  end

  it "has correct list setup" do
    expect(rendered).to have_css(".ncce-activity-list--programme", count: 1)
  end

  it "has the expected section titles" do
    expect(rendered).to have_text("Welcome to your A level Computer Science subject knowledge certificate!")
    expect(rendered).to have_text("Need more support?")
    expect(rendered).to have_text("Practice your knowledge and get your students involved")
  end

  it "has no recommendation list" do
    expect(rendered).not_to have_css(".recommended-courses-wrapper", text: "Courses based on your pathway")
  end

  it "shows all activities" do
    expect(rendered).to have_css(".ncce-activity-list__item", count: 1)
  end

  it "shows no hidden activity title" do
    expect(rendered).not_to have_text("View more activity options")
  end

  it "has support information" do
    expect(rendered).to have_css(".aside-component__heading", text: "Need some help?")
  end

  it "has feedback form" do
    expect(rendered).to have_css(".feedback-component__heading", text: "What can we do better?")
  end

  it "does not use a modal for the test" do
    expect(rendered).not_to have_css(".ncce-modal")
  end

  it "shows the test details on the page" do
    expect(rendered).to have_css("#a-level-test", text: "Ready to take your test?")
    expect(rendered).to have_text("You'll have 60 minutes to answer 40 multiple-choice questions")
    expect(rendered).to have_text("we can extend the test time to 90 minutes")
    expect(rendered).to have_link("email us", href: "mailto:certificationqueries@bcs.uk")
    expect(rendered).to have_link("full details of exam conditions", href: "https://static.teachcomputing.org/alevel-test-conditions.pdf")
    expect(rendered).to have_text("You can take the test twice straight away")
    expect(rendered).to have_text("use the button at the end to come back here")
    expect(rendered).not_to have_text("Senior Leader")
  end

  it "shows the form" do
    expect(rendered).to have_field("user_teacher_reference_number")
    expect(rendered).to have_unchecked_field("assessment_attempt_accepted_conditions")
    expect(rendered).to have_button("Take the test", disabled: true)
  end

  context "when an attempt is in progress" do
    let(:latest_attempt) { create(:assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2020-11-11 14:14")) }

    # The outer before renders the page, so freeze time around it
    around { |example| travel_to(Time.zone.parse("2020-11-11 14:30")) { example.run } }

    it "shows when the test was started" do
      expect(rendered).to have_text("2:14pm on Wednesday 11 November 2020")
    end

    it "shows when a new attempt can be started" do
      expect(rendered).to have_text("4:14pm on Wednesday 11 November 2020")
    end

    it "does not show the form" do
      expect(rendered).not_to have_button("Take the test")
    end

    it "does not show the test details" do
      expect(rendered).not_to have_text("Ready to take your test?")
      expect(rendered).not_to have_text("You'll have 60 minutes")
    end
  end

  context "when the latest attempt timed out" do
    let(:latest_attempt) { create(:timed_out_assessment_attempt, user:, assessment:, created_at: Time.zone.parse("2026-10-10 14:14")) }

    it "shows the date of the attempt that was not completed" do
      expect(rendered).to have_text("10 October 2026")
    end

    it "shows the form" do
      expect(rendered).to have_button("Take the test", disabled: true)
    end
  end
end
