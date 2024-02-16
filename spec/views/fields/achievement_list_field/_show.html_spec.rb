require "rails_helper"

RSpec.describe "fields/achievement_list_field/show", type: :view do
  let(:user) { create(:user) }
  let(:completed_achievement) { create(:completed_achievement, user:, self_verification_info: "I did the thing") }
  let(:ongoing_achievement) { create(:achievement, user:) }
  let(:rejected_achievement) { create(:rejected_achievement, user:) }

  before do
    completed_achievement
    ongoing_achievement
    rejected_achievement
    field = instance_double(
      "AchievementListField",
      attribute: :achievements,
      data: user.achievements,
      state_list: StateMachines::AchievementStateMachine.states
    )
    render partial: subject, locals: {field:}
  end

  it "should list achievments" do
    expect(rendered).to have_css(".achievement", count: 3)
  end

  it "should set correct data attributes" do
    expect(rendered).to have_css("[data-current-state='complete']", count: 1)
    expect(rendered).to have_css("[data-current-state='rejected']", count: 1)
    expect(rendered).to have_css("[data-current-state='enrolled']", count: 1)
  end

  it "should show reject option on complete" do
    expect(rendered).to have_css(".button", count: 1, text: "Reject Evidence")
  end
end
