require "rails_helper"

RSpec.describe "Submitting evidence for an activity" do
  let!(:i_belong) { create(:i_belong) }
  let!(:a_level) { create(:a_level) }
  let!(:primary_certificate) { create(:primary_certificate) }
  let!(:secondary_certificate) { create(:secondary_certificate) }
  let!(:cs_accelerator) { create(:cs_accelerator) }

  let!(:programme_activity_grouping) { create(:programme_activity_grouping, programme: i_belong, required_for_completion: 1, community: true) }
  let!(:first_activity) { create(:activity, :community, self_certifiable: true) }
  let!(:second_activity) { create(:activity, :community, self_certifiable: true) }

  let(:user) { create(:user, email: "web@teachcomputing.org") }

  before do
    create(:programme_activity, programme: i_belong, activity: first_activity, programme_activity_grouping:)
    # create(:programme_activity, programme: i_belong, activity: second_activity, programme_activity_grouping:)

    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    stub_attendance_sets
    stub_delegate
    stub_course_templates

    # enrol on i belong
    visit dashboard_path
    scroll_to :bottom
    within ".card--dashboard--i-belong" do
      click_link "Enrol"
    end
  end

  it "lets you freely close the modal before editing" do
    # click the edge of modal to close
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    find(".ncce-modal--expanded").click(x: 0, y: 500)

    # press ESC to close
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    send_keys :escape
    expect(page).to have_no_selector(".ncce-modal--expanded")

    # press the X icon to close
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    find(".icon-close").click
    expect(page).to have_no_selector(".ncce-modal--expanded")
  end

  it "prompts you to save changes before closing after editing" do
    # click the edge of modal to close
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    find(".ncce-modal--expanded textarea").fill_in(with: "asdf")
    find(".ncce-modal--expanded").click(x: 0, y: 500)
    expect(page).to have_text("Discard submitting evidence?")
    click_on "Exit without saving"
    expect(page).to have_no_selector(".ncce-modal--expanded")

    # press ESC to close
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    send_keys :escape
    expect(page).to have_text "Discard submitting evidence?"
    click_on "Exit without saving"
    expect(page).to have_no_selector(".ncce-modal--expanded")

    # press the X icon to close
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    find(".icon-close").click
    expect(page).to have_text "Discard submitting evidence?"
    click_on "Exit without saving"
    expect(page).to have_no_selector(".ncce-modal--expanded")
  end

  it "lets you move forward and backward through the stages" do
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    expect(page).to have_text "1 of 3"
    find(".ncce-modal--expanded textarea").fill_in(with: "step 1")
    find("a", text: "Continue").click

    expect(page).to have_text("2 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 2")
    find("a", text: "Continue").click

    expect(page).to have_text("3 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 3")
    find("a", text: "Back").click

    expect(page).to have_text("2 of 3")
    expect(page).to have_field("Please provide us with evidence of the activity you delivered.", with: "step 2")
    find("a", text: "Back").click

    expect(page).to have_text("1 of 3")
    expect(page).to have_field("Please provide us with evidence of the activity you delivered.", with: "step 1")
  end

  it "lets you save your changes as a draft" do
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    expect(page).to have_text("1 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 1")
    find("a", text: "Continue").click

    expect(page).to have_text("2 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 2")
    find("a", text: "Continue").click

    expect(page).to have_text("3 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 3")

    send_keys :escape
    expect(page).to have_text("Discard submitting evidence?")
    click_on "Save as draft"
    expect(page).to have_no_selector(".ncce-modal--expanded")

    click_on "Continue editing"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    expect(page).to have_field("Please provide us with evidence of the activity you delivered.", with: "step 1")
    find("a", text: "Continue").click

    expect(page).to have_field("Please provide us with evidence of the activity you delivered.", with: "step 2")
    find("a", text: "Continue").click

    expect(page).to have_field("Please provide us with evidence of the activity you delivered.", with: "step 3")
  end

  it "lets you submit your changes" do
    click_on "Submit evidence"
    expect(page).to have_selector(".ncce-modal--expanded h1", text: "Submit evidence")
    expect(page).to have_text("1 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 1")
    find("a", text: "Continue").click

    expect(page).to have_text("2 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 2")
    find("a", text: "Continue").click

    expect(page).to have_text("3 of 3")
    find(".ncce-modal--expanded textarea").fill_in(with: "step 3")

    within ".ncce-modal--expanded" do
      click_on "Submit"
      expect(page).to have_text("Are you sure you want to submit this evidence?")
      click_on "Submit evidence"
    end
    expect(page).to have_no_selector(".ncce-modal--expanded")
  end
end
